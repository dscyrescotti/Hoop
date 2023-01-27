import SwiftUI

public extension UIImage {
    static func loadImage(_ name: Graphic) -> UIImage {
        guard let image = UIImage(named: name.rawValue, in: .designSystem, with: .none) else {
            fatalError("[Error]: The image is not found!")
        }
        return image
    }
}

public extension Image {
    static func loadImage(_ name: Graphic) -> Image {
        Image(name.rawValue, bundle: .designSystem)
    }
}

public enum Graphic: String {
    // MARK: - Balls
    case basketball

    // MARK: - Hoop
    case hoop
    case hoopTexture = "hoop-texture"
}
