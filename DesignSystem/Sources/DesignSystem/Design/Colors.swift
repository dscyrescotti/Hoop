import SwiftUI

public enum Colors: String {
    case ceruleanCrayola = "cerulean_crayola"
    case deepChampagne = "deep_champagne"
    case eerieBlack = "eerie_black"
    case mahogany
    case nonPhotoBlue = "non_photo_blue"
    case rust
    case white
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
