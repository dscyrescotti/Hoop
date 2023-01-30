import Foundation

public typealias Hoops = Array<Hoop>

public struct Hoop {
    public var location: CGPoint
    public let degree: Double
    public let isDynamic: Bool
    public let alignment: NodeAlignment

    public init(
        location: CGPoint,
        degree: Double,
        isDynamic: Bool,
        alignment: NodeAlignment
    ) {
        self.location = location
        self.degree = degree
        self.isDynamic = isDynamic
        self.alignment = alignment
    }
}
