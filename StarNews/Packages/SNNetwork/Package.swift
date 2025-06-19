// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
    name: "SNNetwork",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "SNNetwork",
            targets: ["SNNetwork"]
        )
    ],
    targets: [
        .target(
            name: "SNNetwork"
        ),
    ]
)
