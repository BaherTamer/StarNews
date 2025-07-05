// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Module: String, CaseIterable {
    case shared = "Shared"
    case core = "SNCore"
    case designSystem = "SNDesignSystem"

    var path: String {
        "../../Packages/"
    }
}

private var allModules: [Module] {
    Module
        .allCases
        .filter({ $0 != .shared })
}

// MARK: - Package Local Dependancies
private var dependencies: [Package.Dependency] {
    let dependency = Package.Dependency.self
    return allModules.map({
        dependency.package(
            name: $0.rawValue,
            path: "\($0.path)\($0.rawValue)"
        )
    })
}

private var targets: [PackageDescription.Target.Dependency] {
    let dependency = PackageDescription.Target.Dependency.self
    return allModules.map({
        dependency.byName(name: $0.rawValue)
    })
}

// MARK: - Package
let package = Package(
    name: Module.shared.rawValue,
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: Module.shared.rawValue,
            targets: [
                Module.shared.rawValue
            ]
        ),
    ],
    dependencies: dependencies + [
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            .upToNextMajor(from: "8.1.3")
        ),
    ],
    targets: [
        .target(
            name: Module.shared.rawValue,
            dependencies: targets + [
                "Kingfisher",
            ]
        ),
    ]
)
