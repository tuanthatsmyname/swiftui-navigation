// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Library",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swiftui-navigation", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        )
    ]
)
