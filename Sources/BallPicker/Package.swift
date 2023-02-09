// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BallPicker",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BallPicker",
            targets: ["BallPicker"]
        ),
    ],
    dependencies: [
        .package(path: "../GameCore"),
        .package(path: "../CoreService"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "BallPicker",
            dependencies: [
                .product(name: "Core", package: "GameCore"),
                .product(name: "Routing", package: "GameCore"),
                .product(name: "Defaults", package: "CoreService"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "BallPickerTests",
            dependencies: ["BallPicker"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
