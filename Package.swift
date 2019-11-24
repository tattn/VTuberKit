// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "VTuberKit",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "VTuberKit", targets: ["VTuberKit"])
    ],
    targets: [
        .target(
            name: "VTuberKit",
            dependencies: [
                .package(url: "git@github.com:tattn/VRMKit.git", from: "0.2.5")
            ],
            path: "Sources"
        )
    ]
)
