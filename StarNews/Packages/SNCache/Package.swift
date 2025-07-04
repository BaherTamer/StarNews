// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SNCache",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "SNCache",
            targets: ["SNCache"]
        ),
    ],
    targets: [
        .target(
            name: "SNCache"
        ),
    ]
)
