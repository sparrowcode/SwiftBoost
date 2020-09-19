// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SparrowKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "SparrowKit", targets: ["SparrowKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "SparrowKit", dependencies: []),
        .testTarget(name: "SparrowKitTests", dependencies: ["SparrowKit"])
    ]
)
