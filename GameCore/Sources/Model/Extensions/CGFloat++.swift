import Foundation

public extension CGFloat {
    static func tolerance(for value: CGFloat) -> CGFloat {
        value * CGFloat.random(in: -1.0...1)
    }
}
