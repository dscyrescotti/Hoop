import Core
import Model
import Combine
import SwiftUI

class GameBoardViewModel: ObservableObject {
    let dependency: GameBoardDependency

    @Published var gameState: GameState = .idle
    @Published var points: Int = .zero
    @Published var winningSteak: Int = .zero
    @Published var lives: Int = .zero

    lazy private(set) var restartTrigger = PassthroughSubject<Void, Never>()
    lazy private(set) var airBallTrigger = PassthroughSubject<Void, Never>()

    var timer: AnyCancellable?

    var ball: Ball { dependency.gameManager.ball }
    var hoops: Hoops { dependency.gameManager.hoops }

    private var cancellables = Set<AnyCancellable>()

    public init(dependency: GameBoardDependency) {
        self.dependency = dependency
    }

    func loadGame(on frame: CGRect) {
        dependency.gameManager.loadNewGame(on: frame)
        points = dependency.gameManager.points
        winningSteak = dependency.gameManager.winningSteak
        lives = dependency.gameManager.lives
    }

    func prepareForNextRound(on frame: CGRect, with location: CGPoint) {
        dependency.gameManager.prepareForNextRound(on: frame, with: location)
    }

    func restartGame(action: @escaping () -> Void) {
        restartTrigger
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }

    func handleAirBall(action: @escaping () -> Void) {
        airBallTrigger
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }

    func calculatePoints(_ count: Int, isBankShot: Bool) {
        dependency.gameManager.calculatePoints(count, isBankShot: isBankShot)
        let gainedPoints = dependency.gameManager.points - self.points
        withAnimation {
            let animationDuration = 500
            let steps = min(abs(gainedPoints), 100)
            let stepDuration = (animationDuration / steps)
            self.points += gainedPoints % steps
            (0..<steps).forEach { step in
                let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                let deadline = DispatchTime.now() + updateTimeInterval
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    self.points += Int(gainedPoints / steps)
                }
            }
        }
        self.winningSteak = dependency.gameManager.winningSteak
    }

    func calculateMissing() {
        dependency.gameManager.calculateMissing()
        winningSteak = .zero
        withAnimation {
            lives -= 1
        }
    }

    func startTimer() {
        let start = Date()
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map { output in
                output.timeIntervalSince(start)
            }
            .map { timeInterval in
                Int(timeInterval)
            }
            .sink { [weak self] seconds in
                if seconds >= 10 {
                    self?.airBallTrigger.send()
                    self?.cancelTimer()
                }
            }
    }

    func cancelTimer() {
        timer?.cancel()
        timer = nil
    }
}
