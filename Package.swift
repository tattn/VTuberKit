// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "VTuberKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "VTuberKit", targets: ["VTuberKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/tattn/VRMKit", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "VTuberKit",
            dependencies: [
                .product(name: "VRMKit", package: "VRMKit"),
                .product(name: "VRMSceneKit", package: "VRMKit"),
            ]
        )
    ]
)
