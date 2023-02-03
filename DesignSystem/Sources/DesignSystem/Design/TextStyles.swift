import SwiftUI

public enum Texture: String {
    case dynaPuffBold = "DynaPuff-Bold"
    case dynaPuffMedium = "DynaPuff-Medium"
    case dynaPuffRegular = "DynaPuff-Regular"
    case dynaPuffSemiBold = "DynaPuff-SemiBold"

    public func of(size: CGFloat) -> Font {
        return Font.custom(self.rawValue, size: size)
    }
}

public enum FontStyle {
    // MARK: - Button
    case button

    // MARK: - Heading
    case heading

    // MARK: - Headline
    case headline

    // MARK: - Title
    case title

    var textStyle: (CGFloat, FontWeight) {
        switch self {
        case .button:
            return (18, .semiBold)
        case .heading:
            return (60, .bold)
        case .headline:
            return (20, .medium)
        case .title:
            return (28, .semiBold)
        }
    }
}

public enum FontWeight {
    case bold
    case medium
    case regular
    case semiBold

    var texture: Texture {
        switch self {
        case .bold:
            return .dynaPuffBold
        case .medium:
            return .dynaPuffMedium
        case .regular:
            return .dynaPuffRegular
        case .semiBold:
            return .dynaPuffSemiBold
        }
    }
}

public extension Font {
    static func of(_ style: FontStyle) -> Font {
        let (size, weight) = style.textStyle
        return weight.texture.of(size: size)
    }
}
