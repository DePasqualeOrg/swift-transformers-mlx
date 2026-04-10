// swift-tools-version: 6.1

import PackageDescription

var packageTargets: [Target] = [
    .target(
        name: "MLXLMTransformers",
        dependencies: [
            .product(name: "MLXLMCommon", package: "mlx-swift-lm"),
            .product(name: "Transformers", package: "swift-transformers"),
        ]
    ),
    .target(
        name: "MLXEmbeddersTransformers",
        dependencies: [
            .product(name: "MLXEmbedders", package: "mlx-swift-lm"),
            .product(name: "MLXLMCommon", package: "mlx-swift-lm"),
            "MLXLMTransformers",
        ]
    ),
    .target(
        name: "TestHelpers",
        dependencies: [
            .product(name: "HuggingFace", package: "swift-huggingface"),
            .product(name: "MLXLMCommon", package: "mlx-swift-lm"),
        ],
        path: "Tests/TestHelpers"
    ),
    .testTarget(
        name: "Benchmarks",
        dependencies: [
            "MLXLMTransformers",
            "TestHelpers",
            .product(name: "HuggingFace", package: "swift-huggingface"),
            .product(name: "BenchmarkHelpers", package: "mlx-swift-lm"),
        ]
    ),
    .testTarget(
        name: "IntegrationTests",
        dependencies: [
            "MLXLMTransformers",
            "TestHelpers",
            .product(name: "HuggingFace", package: "swift-huggingface"),
            .product(name: "IntegrationTestHelpers", package: "mlx-swift-lm"),
        ]
    ),
]

let package = Package(
    name: "swift-transformers-mlx",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "MLXLMTransformers", targets: ["MLXLMTransformers"]),
        .library(name: "MLXEmbeddersTransformers", targets: ["MLXEmbeddersTransformers"]),
    ],
    dependencies: [
        // TODO: Switch from this pinned revision to a major-version dependency once mlx-swift-lm publishes a release that includes PR #118.
        .package(
            url: "https://github.com/ml-explore/mlx-swift-lm.git",
            revision: "89de43c6c8c36f037da3db22230fa5356463b594"
        ),
        .package(url: "https://github.com/huggingface/swift-transformers.git", from: "1.3.0"),
        .package(url: "https://github.com/huggingface/swift-huggingface.git", from: "0.8.1"),
    ],
    targets: packageTargets
)
