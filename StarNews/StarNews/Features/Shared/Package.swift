// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            .upToNextMajor(from: "8.1.3")
        ),
        .package(
            name: "SNDesignSystem",
            path: "../../Packages/SNDesignSystem"
        )
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                "Kingfisher",
                "SNDesignSystem"
            ]
        ),
    ]
)
