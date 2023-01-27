// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameCore",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
        .library(
            name: "Model",
            targets: ["Model"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .target(name: "Model")
            ]
        ),
        .target(
            name: "Model",
            dependencies: []
        ),
        .testTarget(
            name: "GameCoreTests",
            dependencies: ["Core", "Model"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
