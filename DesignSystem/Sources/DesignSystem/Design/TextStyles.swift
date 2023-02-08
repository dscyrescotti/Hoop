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
    case button2

    // MARK: - Caption
    case caption

    // MARK: - Heading
    case heading

    // MARK: - Headline
    case headline
    case headline2
    case headline3

    // MARK: - Title
    case title
    case largeTitle

    var textStyle: (CGFloat, FontWeight) {
        switch self {
        // MARK: - Button
        case .button:
            return (18, .semiBold)
        case .button2:
            return (22, .bold)

        case .caption:
            return (12, .medium)

        // MARK: - Heading
        case .heading:
            return (60, .bold)

        // MARK: - Headline
        case .headline:
            return (20, .medium)
        case .headline2:
            return (24, .semiBold)
        case .headline3:
            return (30, .bold)

        // MARK: - Title
        case .title:
            return (28, .semiBold)
        case .largeTitle:
            return (35, .bold)
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
