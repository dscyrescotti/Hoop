import SwiftUI

public extension Image {
    static func loadImage(_ name: Icons) -> Image {
        Image(systemName: name.rawValue)
    }
}

public enum Icons: String {
    case arrowCounterclockwise = "arrow.counterclockwise"
    case heartFill = "heart.fill"
    case house
}
