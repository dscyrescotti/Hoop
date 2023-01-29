import SwiftUI

public enum Colors: String {
    case deepChampagne = "deep_champagne"
    case rust
}

public extension Color {
    static func of(_ color: Colors) -> Color {
        Color(color.rawValue, bundle: .designSystem)
    }
}
