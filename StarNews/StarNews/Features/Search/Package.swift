// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum Module: String, CaseIterable {
    case search = "Search"
    // Local
    case cache = "SNCache"
    case core = "SNCore"
    case designSystem = "SNDesignSystem"
    case network = "SNNetwork"
    case shared = "Shared"
    case articleDetails = "ArticleDetails"
    
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
        .filter({ $0 != .search })
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
    name: Module.search.rawValue,
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: Module.search.rawValue,
            targets: [
                Module.search.rawValue
            ]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: Module.search.rawValue,
            dependencies: targets
        ),
    ]
)
