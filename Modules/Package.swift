// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Modules",
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "UseCases", targets: ["UseCases"]),
        .library(name: "Presentation", targets: ["Presentation"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Domain", dependencies: []),
        .target(name: "UseCases", dependencies: ["Domain"]),
        .target(name: "Presentation", dependencies: ["UseCases"]),
        
        .testTarget(name: "PresentationUnitTests", dependencies: []),
    ]
)
