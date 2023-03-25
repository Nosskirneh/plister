// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "plister",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.3"),
    ],
    targets: [
        .target(
            name: "plister",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
