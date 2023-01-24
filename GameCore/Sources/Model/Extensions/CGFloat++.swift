import Foundation

public extension CGFloat {
    static var tolerance: CGFloat {
        20 * CGFloat.random(in: -1.0...1)
    }
}
