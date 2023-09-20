// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Chat",
            targets: ["Chat"]
        ),
        .library(
            name: "Meeting",
            targets: ["Meeting"]
        ),
        .library(
            name: "Mortgage",
            targets: ["Mortgage"]
        )
    ],
    dependencies: [
        .package(path: "../Library")
    ],
    targets: [
        .target(
            name: "Chat"
        ),
        .target(
            name: "Meeting",
            dependencies: [
                .product(name: "Navigation", package: "Library")
            ]
        ),
        .target(
            name: "Mortgage",
            dependencies: [
                .product(name: "Navigation", package: "Library")
            ]
        )
    ]
)
