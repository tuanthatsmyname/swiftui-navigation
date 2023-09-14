// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Activation",
            targets: ["Activation"]
        ),
        .library(
            name: "AppStart",
            targets: ["AppStart"]
        ),
        .library(
            name: "Dashboard",
            targets: ["Dashboard"]
        ),
        .library(
            name: "Login",
            targets: ["Login"]
        ),
        .library(
            name: "Root",
            targets: ["Root"]
        )
    ],
    dependencies: [
        .package(path: "../Library"),
        .package(url: "https://github.com/pointfreeco/swiftui-navigation", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "Activation",
            dependencies: [
                .product(name: "Navigation", package: "Library"),
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        ),
        .target(
            name: "AppStart",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        ),
        .target(
            name: "Dashboard",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        ),
        .target(
            name: "Login",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        ),
        .target(
            name: "Root",
            dependencies: [
                "Activation",
                "AppStart",
                "Dashboard",
                "Login",
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        )
    ]
)
