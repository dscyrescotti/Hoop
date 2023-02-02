// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameBoard",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "GameBoard",
            targets: ["GameBoard"]
        ),
    ],
    dependencies: [
        .package(path: "../GameCore"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "GameBoard",
            dependencies: [
                .product(name: "Core", package: "GameCore"),
                .product(name: "Model", package: "GameCore"),
                .product(name: "DesignSystem", package: "DesignSystem"),
            ]
        ),
        .testTarget(
            name: "GameBoardTests",
            dependencies: ["GameBoard"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
