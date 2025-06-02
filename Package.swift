// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorLottieSplashScreen",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorLottieSplashScreenPlugin",
            targets: ["LottieSplashScreenPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "LottieSplashScreenPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/LottieSplashScreenPlugin"),
        .testTarget(
            name: "LottieSplashScreenPluginTests",
            dependencies: ["LottieSplashScreenPlugin"],
            path: "ios/Tests/LottieSplashScreenPluginTests")
    ]
)