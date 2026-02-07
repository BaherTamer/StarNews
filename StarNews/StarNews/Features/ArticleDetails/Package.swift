// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum Module: String, CaseIterable {
    case articleDetails = "ArticleDetails"
    // Local
    case cache = "SNCache"
    case network = "SNNetwork"
    case shared = "Shared"
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
        case .articleDetails:
            true
        default:
            false
        }
    }
}

private var allModules: [Module] {
    Module
        .allCases
        .filter({ $0 != .articleDetails })
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
        .testTarget(
            name: Module.articleDetails.rawValue + "Tests",
            dependencies: testTargets
        )
    ]
)
