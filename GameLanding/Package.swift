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
        .package(path: "../GameCore"),
        .package(path: "../CoreService"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "GameLanding",
            dependencies: [
                .product(name: "Core", package: "GameCore"),
                .product(name: "Model", package: "GameCore"),
                .product(name: "Routing", package: "GameCore"),
                .product(name: "Defaults", package: "CoreService"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "GameLandingTests",
            dependencies: ["GameLanding"]
        ),
    ]
)
