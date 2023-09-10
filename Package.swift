// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "VTuberKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "VTuberKit", targets: ["VTuberKit"])
    ],
    dependencies: [
        .package(url: "git@github.com:tattn/VRMKit.git", from: "0.4.4")
    ],
    targets: [
        .target(
            name: "VTuberKit",
            dependencies: ["VRMKit", "VRMSceneKit"],
            path: "Sources"
        )
    ]
)
