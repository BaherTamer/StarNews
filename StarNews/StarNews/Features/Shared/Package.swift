// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum Module: String, CaseIterable {
    case shared = "Shared"
    // Local
    case core = "SNCore"
    case designSystem = "SNDesignSystem"
    // Remote
    case kingfisher = "Kingfisher"
    
    // Helpers
    var isRemote: Bool {
        switch self {
        case .kingfisher:
            true
        default:
            false
        }
    }

    var path: String {
        switch self {
        case .kingfisher:
            "https://github.com/onevcat/Kingfisher.git"
        default:
            "../../Packages/"
        }
    }
    
    var version: Version {
        switch self {
        case .kingfisher:
            "8.1.3"
        default:
            ""
        }
    }
}

private var allModules: [Module] {
    Module
        .allCases
        .filter({ $0 != .shared })
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
    dependencies: dependencies,
    targets: [
        .target(
            name: Module.shared.rawValue,
            dependencies: targets
        ),
    ]
)
