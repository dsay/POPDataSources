import PackageDescription

let package = Package(
    name: "POPDataSource",
    products: [
        .library(
            name: "POPDataSource",
            targets: ["POPDataSource"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "POPDataSource",
            dependencies: []),
        .testTarget(
            name: "POPDataSourceTests",
            dependencies: ["POPDataSource"]),
    ]
)
