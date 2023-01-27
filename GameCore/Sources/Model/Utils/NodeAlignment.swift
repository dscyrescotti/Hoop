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

    public var offset: CGFloat {
        switch self {
        case .left:
            return -100
        case .center:
            return 0
        case .right:
            return 100
        }
    }
}
