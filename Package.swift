// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "POPDataSources",
    platforms: [.iOS(.v11)],
    products: [
           .library(
               name: "POPDataSources",
               targets: ["POPDataSources"])
       ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "POPDataSources",
            path: "Sources"),
        .testTarget(
            name: "POPDataSourcesTests",
            dependencies: ["POPDataSources"]),
    ],
    swiftLanguageVersions: [.v5]
)
