// swift-tools-version: 6.2

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "Calculator",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "Calculator",
            targets: ["Calculator"]
        ),
    ],
    targets: [
        .target(
            name: "Calculator",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "CalculatorTests",
            dependencies: ["Calculator"],
            swiftSettings: swiftSettings
        ),
    ]
)
