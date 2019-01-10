// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "NewMain",
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "NewMain",
            dependencies: ["NewType"]),
        //.testTarget(
            //name: "NewMain",
            //dependencies: ["NewMain"]),
        ],
    dependencies: [
        .package(path:"../NewType")
    ]
)
