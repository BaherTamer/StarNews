// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SNDesignSystem",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "SNDesignSystem",
            targets: ["SNDesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "SNDesignSystem"
        ),

    ]
)
