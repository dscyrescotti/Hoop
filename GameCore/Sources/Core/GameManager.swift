import Model
import SpriteKit
import Foundation

public class GameManager {
    public var hoops: Hoops = []
    public var ball: Ball = Ball()
    public var alignment: NodeAlignment = .random()
    public var point: Int = .zero

    public var baseLine: CGFloat = .zero

    public init() { }
}

// MARK: - GAME LOADING
extension GameManager {
    /// load the new game
    public func loadNewGame(on frame: CGRect) {
        seedBall(on: frame)
        hoops.removeAll()
        for index in 1...3 {
            seedHoop(on: frame, for: index)
        }
    }

    /// prepare for next shot
    public func prepareForNextRound(on frame: CGRect, with location: CGPoint) {
        ball.location = location
        ball.location.y = baseLine
        let hoop = hoops.removeFirst()
        let diff = hoop.location.y - baseLine
        for index in hoops.indices {
            hoops[index].location.y -= diff
        }
        seedHoop(on: frame)
    }

    /// seed ball on frame arbitrarily
    private func seedBall(on frame: CGRect) {
        alignment = .random(.center)
        baseLine = frame.minY + 200
        let ballPosition = CGPoint(
            x: frame.midX + alignment.offset + .tolerance(for: 20),
            y: baseLine
        )
        ball = Ball(location: ballPosition)
    }

    /// seed hoop on frame arbitrarily
    private func seedHoop(on frame: CGRect, for index: Int = 3) {
        alignment = .random(alignment)
        let x = frame.midX + alignment.offset + .tolerance(for: 10)
        let y = baseLine + 250 * CGFloat(index) + .tolerance(for: 40)
        let hoopPosition = CGPoint(x: x, y: y)
        let hoop = Hoop(
            location: hoopPosition,
            degree: .zero
        )
        hoops.append(hoop)
    }
}
