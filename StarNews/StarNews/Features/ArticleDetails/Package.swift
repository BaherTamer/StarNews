// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Module: String, CaseIterable {
    case articleDetails = "ArticleDetails"
    case cache = "SNCache"
    case core = "SNCore"
    case designSystem = "SNDesignSystem"
    case network = "SNNetwork"
    case shared = "Shared"

    var path: String {
        switch self {
        case .shared:
            "../"
        default:
            "../../Packages/"
        }
    }
}

private var allModules: [Module] {
    Module
        .allCases
        .filter({ $0 != .articleDetails })
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
    name: Module.articleDetails.rawValue,
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: Module.articleDetails.rawValue,
            targets: [
                Module.articleDetails.rawValue
            ]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: Module.articleDetails.rawValue,
            dependencies: targets
        ),
    ]
)
