import SwiftUI

public enum Colors: String {
    case rust
    case flame
    case olive
    case peach
    case wheat
    case white
    case mahogany
    case eerieBlack = "eerie_black"
    case nonPhotoBlue = "non_photo_blue"
    case deepChampagne = "deep_champagne"
    case fireEngineRed = "fire_engine_red"
    case ceruleanCrayola = "cerulean_crayola"
}

public extension Color {
    static func of(_ color: Colors) -> Color {
        Color(color.rawValue, bundle: .designSystem)
    }
}

public extension UIColor {
    static func of(_ color: Colors) -> UIColor {
        UIColor(Color.of(color))
    }
}
