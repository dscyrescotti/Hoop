import Foundation

public enum NodeAlignment: CaseIterable {
    case left
    case center
    case right

    public static func random(_ current: NodeAlignment? = nil) -> NodeAlignment {
        let cases = Self.allCases.filter { current != $0 }
        guard let alignment = cases.randomElement() else {
            fatalError()
        }
        return alignment
    }

    public func offset(_ width: CGFloat) -> CGFloat {
        let shift = width / 3
        switch self {
        case .left:
            return -shift
        case .center:
            return 0
        case .right:
            return shift
        }
    }

    public var degree: CGFloat {
        switch self {
        case .left:
            return [0, -0.05, -0.1, -0.14, -0.2].randomElement() ?? 0
        case .center:
            return 0
        case .right:
            return [0, 0.05, 0.1, 0.14, 0.2].randomElement() ?? 0
        }
    }
}
