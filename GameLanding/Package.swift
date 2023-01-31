// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameLanding",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "GameLanding",
            targets: ["GameLanding"]
        ),
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../GameCore")
    ],
    targets: [
        .target(
            name: "GameLanding",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Core", package: "GameCore"),
                .product(name: "Model", package: "GameCore")
            ]
        ),
        .testTarget(
            name: "GameLandingTests",
            dependencies: ["GameLanding"]
        ),
    ]
)
