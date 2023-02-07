import Model
import Persistency

// MARK: - BallObject
extension BallObject {
    func copy(from ball: Ball) {
        self.xPoint = ball.location.x
        self.yPoint = ball.location.y
    }
}

// MARK: - HoopObject
extension HoopObject {
    func copy(from hoop: Hoop) {
        self.xPoint = hoop.location.x
        self.yPoint = hoop.location.y
        self.degree = hoop.degree
        self.isDynamic = hoop.isDynamic
        self.nodeAlignment = hoop.alignment.rawValue
    }
}
