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
        ),
        .library(
            name: "Routing",
            targets: ["Routing"]
        )
    ],
    dependencies: [
        .package(path: "../CoreService")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .target(name: "Model"),
                .product(name: "Persistency", package: "CoreService")
            ]
        ),
        .target(
            name: "Model",
            dependencies: []
        ),
        .target(
            name: "Routing",
            dependencies: [
                .target(name: "Model")
            ]
        ),
        .testTarget(
            name: "GameCoreTests",
            dependencies: ["Core", "Model", "Routing"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
