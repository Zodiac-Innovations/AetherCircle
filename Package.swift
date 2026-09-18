// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "AetherCircle",
    platforms: [
        .visionOS(.v2),
    ],
    products: [
        .library(
            name: "AetherCircleCore",
            targets: ["AetherCircleCore"]
        ),
        .library(
            name: "AetherCircleAVP",
            targets: ["AetherCircleAVP"]
        ),
    ],
    targets: [
        .target(
            name: "AetherCircleCore"
        ),
        .target(
            name: "AetherCircleAVP",
            dependencies: ["AetherCircleCore"]
        ),
        .testTarget(
            name: "AetherCircleCoreTests",
            dependencies: ["AetherCircleCore"]
        ),
        .testTarget(
            name: "AetherCircleAVPTests",
            dependencies: ["AetherCircleAVP"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
