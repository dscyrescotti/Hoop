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
        ),
        .library(
            name: "Persistency",
            targets: ["Persistency"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .target(name: "Model"),
                .target(name: "Persistency")
            ]
        ),
        .target(
            name: "Model",
            dependencies: []
        ),
        .target(
            name: "Routing",
            dependencies: []
        ),
        .target(
            name: "Persistency",
            dependencies: [
                .target(name: "Model")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "GameCoreTests",
            dependencies: ["Core", "Model", "Routing"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
