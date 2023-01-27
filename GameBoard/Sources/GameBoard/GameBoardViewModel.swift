import Core
import Model
import Combine
import SwiftUI

public class GameBoardViewModel: ObservableObject {
    let dependency: GameBoardDependency

    @Published var gameState: GameState = .idle

    lazy private(set) var restartTrigger = PassthroughSubject<Void, Never>()

    var ball: Ball { dependency.gameManager.ball }
    var hoops: Hoops { dependency.gameManager.hoops }

    private var cancellables = Set<AnyCancellable>()

    public init(dependency: GameBoardDependency) {
        self.dependency = dependency
    }

    func loadGame(on frame: CGRect) {
        dependency.gameManager.loadNewGame(on: frame)
    }

    func prepareForNextRound(on frame: CGRect, with location: CGPoint) {
        dependency.gameManager.prepareForNextRound(on: frame, with: location)
    }

    func restartGame(action: @escaping () -> Void) {
        restartTrigger
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }
}
