import SwiftUI

public extension UIImage {
    static func loadImage(_ name: Graphic) -> UIImage {
        guard let image = UIImage(named: name.rawValue, in: .designSystem, with: .none) else {
            fatalError("[Error]: The image is not found!")
        }
        return image
    }

    static func loadBall(_ name: String) -> UIImage {
        guard let image = UIImage(named: name, in: .designSystem, with: .none) else {
            fatalError("[Error]: The image is not found!")
        }
        return image
    }
}

public extension Image {
    static func loadImage(_ name: Graphic) -> Image {
        Image(name.rawValue, bundle: .designSystem)
    }

    static func loadBall(_ name: String) -> Image {
        Image(name, bundle: .designSystem)
    }
}

public enum Graphic: String {
    // MARK: - Doodle
    case doodleArt = "doodle-art"

    // MARK: - Heart
    case heart

    // MARK: - Hoop
    case hoop
    case hoopTexture = "hoop-texture"
    case ballPassingHoop = "ball-passing-hoop"

    // MARK: - Trophy
    case trophy
    case goldTrophy = "gold-trophy"
    case silverTrophy = "silver-trophy"
    case bronzeTrophy = "bronze-trophy"
}
