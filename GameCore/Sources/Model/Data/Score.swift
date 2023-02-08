import Foundation

public typealias Scores = Array<Score>

public struct Score: Identifiable {
    public let id: String
    public let points: Int
    public let date: Date

    public init(id: String, points: Int, date: Date) {
        self.id = id
        self.points = points
        self.date = date
    }
}
