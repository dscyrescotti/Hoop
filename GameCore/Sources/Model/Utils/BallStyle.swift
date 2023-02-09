import Foundation

public typealias BallStyles = [BallStyle]

public enum BallStyle: String, Codable, Identifiable {
    public var id: String {
        self.rawValue
    }

    case basketball
    case niviaBasketball = "nivia-basketball"
    case vectorXBbasketball = "vector-x-basketball"
    case oldWilsonBasketball = "old-wilson-basketball"
    case wilsonNbaBasketball = "wilson-nba-basketball"
    case blackWilsonBasketball = "black-wilson-basketball"
    case spaldingNbaBasketball = "spalding-nba-basketball"
    case sliverWilsonBasketball = "sliver-wilson-basketball"
    case goldenSpaldingBasketball = "golden-spalding-basketball"
    case signedSpaldingBasketball = "signed-spalding-basketball"
    case spaldingColorfulBasketball = "spalding-colorful-basketball"
}

public extension BallStyles {
    static let all: [BallStyle] = [
        .basketball,
        .niviaBasketball,
        .vectorXBbasketball,
        .oldWilsonBasketball,
        .wilsonNbaBasketball,
        .spaldingNbaBasketball,
        .spaldingColorfulBasketball,
        .signedSpaldingBasketball,
        .blackWilsonBasketball,
        .sliverWilsonBasketball,
        .goldenSpaldingBasketball
    ]
}
