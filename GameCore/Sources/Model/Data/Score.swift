import Foundation

public typealias Scores = Array<Score>

public struct Score: Identifiable, Hashable {
    public let id: String
    public let points: Int
    public let date: Date
    public let isNew: Bool

    public init(
        id: String,
        points: Int,
        date: Date,
        isNew: Bool
    ) {
        self.id = id
        self.points = points
        self.date = date
        self.isNew = isNew
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
