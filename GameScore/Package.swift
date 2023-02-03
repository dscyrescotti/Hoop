// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameScore",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "GameScore",
            targets: ["GameScore"]
        ),
    ],
    dependencies: [
        .package(path: "../GameCore"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "GameScore",
            dependencies: [
                .product(name: "Core", package: "GameCore"),
                .product(name: "Model", package: "GameCore"),
                .product(name: "Routing", package: "GameCore"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "GameScoreTests",
            dependencies: ["GameScore"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
