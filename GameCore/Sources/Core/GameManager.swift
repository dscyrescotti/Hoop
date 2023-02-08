import Model
import SpriteKit
import Foundation
import Persistency

public class GameManager {
    internal var persistency: PersistencyService

    internal var gameObject: GameObject?

    public var hoops: Hoops = []
    public var ball: Ball = Ball()
    public var alignment: NodeAlignment = .random()
    public var points: Int = .zero
    public var winningSteak: Int = .zero
    public var lives: Int = .zero

    public var baseLine: CGFloat = .zero

    public init(persistency: PersistencyService) {
        self.persistency = persistency
        self.gameObject = loadExistingGameObject()
    }
}

// MARK: - GAME LOADING
extension GameManager {
    public var isExistsGame: Bool {
        return gameObject != nil
    }

    /// load the new game
    public func loadGame(on frame: CGRect, mode: GameMode) {
        switch mode {
        case .new:
            loadNewGame(on: frame)
        case .existing:
            loadExistingGame(on: frame)
        }
    }

    private func loadNewGame(on frame: CGRect) {
        points = 0
        winningSteak = 0
        lives = 3
        seedBall(on: frame)
        hoops.removeAll()
        for index in 1...3 {
            seedHoop(on: frame, for: index)
        }
        deleteGameObject()
        self.gameObject = loadNewGameObject()
    }

    private func loadExistingGame(on frame: CGRect) {
        if let existingGameObject = gameObject {
            points = existingGameObject.points
            winningSteak = existingGameObject.winningSteak
            lives = existingGameObject.lives
            alignment = NodeAlignment(rawValue: existingGameObject.nodeAlignment) ?? .center
            baseLine = existingGameObject.ball?.yPoint ?? 0
            ball = existingGameObject.ball?.model ?? Ball()
            hoops = existingGameObject.hoops?.array
                .compactMap { $0 as? HoopObject }
                .map { $0.model } ?? []
            self.gameObject = existingGameObject
        }
    }

    /// prepare for next ball
    public func prepareForNextRound(on frame: CGRect, with location: CGPoint) {
        ball.location = location
        ball.location.y = baseLine
        let hoop = hoops.removeFirst()
        let diff = hoop.location.y - baseLine
        for index in hoops.indices {
            hoops[index].location.y -= diff
        }
        seedHoop(on: frame)
        updateGameObject()
    }

    /// calculate points after shot
    public func calculatePoints(_ count: Int, isBankShot: Bool) {
        var points = 3
        if count > 1 {
            points += 2 * (count - 1)
        }
        if isBankShot {
            points += 2
        }
        if winningSteak >= 2 {
            points *= winningSteak
        }
        winningSteak += 1
        self.points += points
        updateGamePoints()
    }

    /// handle ball missing
    public func calculateMissing() {
        winningSteak = .zero
        lives -= 1
        updateGameLives()
    }

    /// seed ball on frame arbitrarily
    private func seedBall(on frame: CGRect) {
        alignment = .random(.center)
        baseLine = frame.minY + 200
        let ballPosition = CGPoint(
            x: frame.midX + alignment.offset(frame.width) + .tolerance(for: 20),
            y: baseLine
        )
        ball = Ball(location: ballPosition)
    }

    /// seed hoop on frame arbitrarily
    private func seedHoop(on frame: CGRect, for index: Int = 3) {
        let previous = alignment
        alignment = .random(alignment)
        let x = frame.midX + alignment.offset(frame.width) + .tolerance(for: 10)
        let y = baseLine + 280 * CGFloat(index) + .tolerance(for: 20)
        var degree = alignment.degree
        let isDynamic = Bool.random()
        if alignment == .center {
            degree += -previous.degree
        }
        let hoopPosition = CGPoint(x: x, y: y)
        let hoop = Hoop(
            location: hoopPosition,
            degree: degree,
            isDynamic: isDynamic,
            alignment: alignment
        )
        hoops.append(hoop)
    }
}
