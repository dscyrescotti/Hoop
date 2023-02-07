// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        ),
    ],
    dependencies: [
        .package(path: "../GameCore"),
        .package(path: "../GameBoard"),
        .package(path: "../GameScore"),
        .package(path: "../CoreService"),
        .package(path: "../GameLanding"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Core", package: "GameCore"),
                .product(name: "Model", package: "GameCore"),
                .product(name: "Routing", package: "GameCore"),
                .product(name: "GameBoard", package: "GameBoard"),
                .product(name: "GameScore", package: "GameScore"),
                .product(name: "Persistency", package: "CoreService"),
                .product(name: "GameLanding", package: "GameLanding"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
