// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "FusionMapControl",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "FusionMapControl",
            type: .static,
            targets: [
                "FusionMapControl"
            ]
        )
    ],
    dependencies: [
		.package(name: "FusionLocation", url: "https://github.com/pavloboiko/FusionLocation.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "FusionMapControl",
            dependencies: [
            	.product(name: "FusionLocation", package: "FusionLocation"),
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)