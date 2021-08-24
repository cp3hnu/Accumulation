// swift-tools-version:5.1
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
        .package(url: "https://github.com/cp3hnu/Bricking.git", from: "4.1.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.2.0")
    ],
    targets: [
        .target(name: "Accumulation", dependencies: ["Bricking", "RxSwift", "RxCocoa"], path: "Accumulation")
    ],
    swiftLanguageVersions: [.v5]
)

