import Model
import SpriteKit
import Foundation

public class GameManager {
    public var hoops: Hoops = []
    public var ball: Ball = Ball()
    public var alignment: NodeAlignment = .random()
    public var points: Int = .zero
    public var winningSteak: Int = .zero
    public var lives: Int = .zero

    public var baseLine: CGFloat = .zero

    public init() { }
}

// MARK: - GAME LOADING
extension GameManager {
    /// load the new game
    public func loadNewGame(on frame: CGRect) {
        points = 0
        winningSteak = 0
        lives = 3
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
    }

    /// handle ball missing
    public func calculateMissing() {
        winningSteak = .zero
        lives -= 1
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
        let y = baseLine + 250 * CGFloat(index) + .tolerance(for: 40)
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
