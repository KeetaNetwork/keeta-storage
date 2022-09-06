// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "keeta-secure-storage",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "keeta-secure-storage",
            targets: ["keeta-secure-storage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "20.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "keeta-secure-storage",
            dependencies: [.product(name: "KeychainSwift", package: "keychain-swift"),]),
        .testTarget(
            name: "keeta-secure-storageTests",
            dependencies: ["keeta-secure-storage"]),
    ]
)
