import Model
import SpriteKit
import Foundation

public class GameManager {
    public var hoops: Hoops = []
    public var ball: Ball = Ball()
    public var alignment: NodeAlignment = .random()
    public var baseLine: CGFloat = .zero

    public init() { }
}

// MARK: - GAME LOADING
extension GameManager {
    public func loadNewGame(on frame: CGRect) {
        seedBall(on: frame)
        for index in 1...3 {
            seedHoop(on: frame, for: index)
        }
    }

    // seed ball on frame arbitrarily
    private func seedBall(on frame: CGRect) {
        alignment = .random(.center)
        baseLine = frame.minY + 200
        let ballPosition = CGPoint(
            x: frame.midX + alignment.offset + .tolerance(for: 20),
            y: baseLine
        )
        ball = Ball(location: ballPosition)
    }

    // seed hoop on frame arbitrarily
    private func seedHoop(on frame: CGRect, for index: Int = 3) {
        alignment = .random(alignment)
        let x = frame.midX + alignment.offset + .tolerance(for: 20)
        let y = baseLine + 300 * CGFloat(index) + .tolerance(for: 70)
        let hoopPosition = CGPoint(x: x, y: y)
        let hoop = Hoop(
            location: hoopPosition,
            degree: .zero
        )
        hoops.append(hoop)
    }
}
