// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreService",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Defaults",
            targets: ["Defaults"]
        ),
        .library(
            name: "Persistency",
            targets: ["Persistency"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Defaults",
            dependencies: []
        ),
        .target(
            name: "Persistency",
            dependencies: []
        ),
        .testTarget(
            name: "CoreServiceTests",
            dependencies: ["Persistency"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
