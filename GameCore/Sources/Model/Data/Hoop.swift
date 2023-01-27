import Foundation

public typealias Hoops = Array<Hoop>

public struct Hoop {
    public var location: CGPoint
    public let degree: Double

    public init(location: CGPoint, degree: Double) {
        self.location = location
        self.degree = degree
    }
}
