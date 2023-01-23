import Foundation

class DesignSystem { }

public extension Bundle {
    static var designSystem: Bundle = {
        let bundleName = "DesignSystem_DesignSystem"

        let candidates = [
            Bundle.main.resourceURL,
            Bundle(for: DesignSystem.self).resourceURL,
            Bundle(for: DesignSystem.self).resourceURL?.deletingLastPathComponent(),
            Bundle.main.bundleURL,
            Bundle(for: DesignSystem.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: DesignSystem.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]

        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
