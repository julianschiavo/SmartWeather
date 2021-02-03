// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmartWeather",
    platforms: [
        .macOS(.v10_14), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .executable(name: "SmartWeather", targets: ["SmartWeather"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.2")
    ],
    targets: [
        .target(name: "SmartWeather",
                dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
                resources: [.copy("WeatherModel.mlmodelc")])
    ]
)
