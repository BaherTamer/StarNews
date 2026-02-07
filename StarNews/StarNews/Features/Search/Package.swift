// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum Module: String, CaseIterable {
    case search = "Search"
    // Local
    case cache = "SNCache"
    case network = "SNNetwork"
    case shared = "Shared"
    case articleDetails = "ArticleDetails"
    // Remote
    case factory = "Factory"
    
    // Helpers
    var isRemote: Bool {
        switch self {
        case .factory:
            true
        default:
            false
        }
    }

    var path: String {
        switch self {
        case .factory:
            "https://github.com/hmlongco/Factory"
        case .shared:
            "../"
        default:
            "../../Packages/"
        }
    }
    
    var version: Version {
        switch self {
        case .factory:
            "2.3.0"
        default:
            ""
        }
    }
    
    var isTestable: Bool {
        switch self {
        case .search:
            true
        default:
            false
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
        if $0.isRemote {
            dependency.package(
                url: $0.path,
                .upToNextMajor(from: $0.version)
            )
        } else {
            dependency.package(
                name: $0.rawValue,
                path: "\($0.path)\($0.rawValue)"
            )
        }
    })
}

private var targets: [PackageDescription.Target.Dependency] {
    let dependency = PackageDescription.Target.Dependency.self
    return allModules.map({
        dependency.byName(name: $0.rawValue)
    })
}

private var testTargets: [PackageDescription.Target.Dependency] {
    let dependency = PackageDescription.Target.Dependency.self
    return Module.allCases.filter(\.isTestable).map({
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
        .testTarget(
            name: Module.search.rawValue + "Tests",
            dependencies: testTargets
        )
    ]
)
