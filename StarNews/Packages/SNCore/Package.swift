// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SNCore",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "SNCore",
            targets: ["SNCore"]
        ),
    ],
    targets: [
        .target(
            name: "SNCore"
        ),
    ]
)
