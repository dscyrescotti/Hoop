import SwiftUI

public extension Image {
    static func loadImage(_ name: Icons) -> Image {
        Image(systemName: name.rawValue)
    }
}

public enum Icons: String {
    case house
    case xmark
    case playFill = "play.fill"
    case pauseFill = "pause.fill"
    case trashFill = "trash.fill"
    case playCircleFill = "play.circle.fill"
    case gamecontrollerFill = "gamecontroller.fill"
    case checkmarkCircleFill = "checkmark.circle.fill"
    case arrowCounterclockwise = "arrow.counterclockwise"
    case alignVerticalBottomFill = "align.vertical.bottom.fill"
}
