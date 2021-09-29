// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Accumulation",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v11)
    ],
    products: [
        .library(name: "Accumulation", targets: ["Accumulation"])
    ],
    dependencies: [
        .package(url: "https://github.com/cp3hnu/Bricking.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        .target(
            name: "Accumulation",
            dependencies: [
                "Bricking",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift")],
            path: "Accumulation"
        )
    ],
    swiftLanguageVersions: [.v5]
)

