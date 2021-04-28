// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "SparrowKit",
    platforms: [
        .iOS(.v12), .tvOS(.v12), .watchOS(.v6)
    ],
    products: [
        .library(name: "SparrowKit", targets: ["SparrowKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "SparrowKit", dependencies: [])
    ]
)
