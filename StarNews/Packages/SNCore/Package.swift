// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum Module: String, CaseIterable {
    case network = "SNCore"
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
        default:
            "../"
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
}

private var allModules: [Module] {
    Module
        .allCases
        .filter({ $0 != .network })
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

// MARK: - Package
let package = Package(
    name: Module.network.rawValue,
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: Module.network.rawValue,
            targets: [
                Module.network.rawValue
            ]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: Module.network.rawValue,
            dependencies: targets
        ),
    ]
)
