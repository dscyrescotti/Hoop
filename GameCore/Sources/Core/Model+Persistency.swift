import Model
import Foundation
import Persistency

// MARK: - BallObject
extension BallObject {
    func copy(from ball: Ball) {
        self.xPoint = ball.location.x
        self.yPoint = ball.location.y
    }

    var model: Ball {
        Ball(location: CGPoint(x: xPoint, y: yPoint))
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

    var model: Hoop {
        Hoop(
            location: CGPoint(x: xPoint, y: yPoint),
            degree: degree,
            isDynamic: isDynamic,
            alignment: NodeAlignment(rawValue: nodeAlignment) ?? .center
        )
    }
}
