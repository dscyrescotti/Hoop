import Foundation

public typealias Hoops = Array<Hoop>

public struct Hoop {
    public let location: CGPoint
    public let degree: Double

    public init(location: CGPoint, degree: Double) {
        self.location = location
        self.degree = degree
    }
}
