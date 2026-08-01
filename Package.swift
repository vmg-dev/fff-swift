// swift-tools-version: 5.10

import Foundation
import PackageDescription

let localArtifactPath = "Artifacts/CFFF.xcframework"
let binaryVersion = "0.1.0"
let binaryChecksum = "00824e1525201f3d7ed5f6351dfb7d00e9c50edae58e16e07f5f49ad9665787f"
let cfffTarget: Target = FileManager.default.fileExists(atPath: localArtifactPath)
    ? .binaryTarget(name: "CFFF", path: localArtifactPath)
    : .binaryTarget(
        name: "CFFF",
        url: "https://github.com/vmg-dev/fff-swift/releases/download/\(binaryVersion)/CFFF.xcframework.zip",
        checksum: binaryChecksum
    )

let package = Package(
    name: "FFFKit",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "FFFKit", targets: ["FFFKit"])
    ],
    targets: [
        cfffTarget,
        .target(
            name: "FFFKit",
            dependencies: ["CFFF"],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreServices"),
                .linkedFramework("Security"),
                .linkedLibrary("iconv"),
                .linkedLibrary("z")
            ]
        ),
        .testTarget(name: "FFFKitTests", dependencies: ["FFFKit"])
    ],
    swiftLanguageVersions: [.v5]
)
