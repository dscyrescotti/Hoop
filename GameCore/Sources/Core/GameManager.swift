import Model
import SpriteKit
import Foundation

public class GameManager {
    public var hoops: Hoops = []
    public var ball: Ball?
    public var alignment: NodeAlignment = .random()

    public init() { }
}

// MARK: - GAME LOADING
extension GameManager {
    public func loadGame(on frame: CGRect, for mode: GameMode) {
        switch mode {
        case .new:
            loadNewGame(on: frame)
        case .existing:
            loadExistingGame(on: frame)
        }
    }

    private func loadNewGame(on frame: CGRect) {
        /// seed the ball
        let ballPosition = CGPoint(
            x: frame.midX + alignment.offset + .tolerance,
            y: frame.minY + 200
        )
        ball = Ball(location: ballPosition)
    }

    private func loadExistingGame(on frame: CGRect) { }
}
