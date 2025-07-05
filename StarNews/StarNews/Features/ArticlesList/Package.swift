// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum Module: String, CaseIterable {
    case articlesList = "ArticlesList"
    // Local
    case cache = "SNCache"
    case core = "SNCore"
    case designSystem = "SNDesignSystem"
    case network = "SNNetwork"
    case shared = "Shared"
    case articleDetails = "ArticleDetails"
    case search = "Search"
    
    // Helpers
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
        .filter({ $0 != .articlesList })
}

// MARK: - Dependancies
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
    name: Module.articlesList.rawValue,
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: Module.articlesList.rawValue,
            targets: [
                Module.articlesList.rawValue
            ]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: Module.articlesList.rawValue,
            dependencies: targets
        ),
    ]
)
