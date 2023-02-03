import SwiftUI

public extension Image {
    static func loadImage(_ name: Icons) -> Image {
        Image(systemName: name.rawValue)
    }
}

public enum Icons: String {
    case house
    case heartFill = "heart.fill"
    case gamecontrollerFill = "gamecontroller.fill"
    case arrowCounterclockwise = "arrow.counterclockwise"
    case alignVerticalBottomFill = "align.vertical.bottom.fill"
}