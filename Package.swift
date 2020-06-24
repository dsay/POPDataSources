// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "POPDataSources",
    platforms: [.iOS(.v11)],
    dependencies: [

    ],
    targets: [
        .target(
            name: "POPDataSources",
            dependencies: []),
        .testTarget(
            name: "POPDataSourcesTests",
            dependencies: ["POPDataSources"]),
    ],
    swiftLanguageVersions: [.v5]
)
