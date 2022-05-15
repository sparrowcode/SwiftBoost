// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftBoost",
    platforms: [
        .iOS(.v13), 
        .tvOS(.v13), 
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftBoost",
            targets: ["SwiftBoost"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftBoost",
            swiftSettings: [
                .define("SWIFTBOOST_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
