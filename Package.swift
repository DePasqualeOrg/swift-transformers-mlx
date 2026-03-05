// swift-tools-version: 6.0

import PackageDescription

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
        // TODO: Change to ml-explore/mlx-swift-lm before PR #118 is merged
        .package(url: "https://github.com/DePasqualeOrg/mlx-swift-lm.git", branch: "swift-tokenizers"),
        // TODO: Change to from: "x.y.z" when a swift-transformers release includes
        // commit e5e227b / swift-huggingface support.
        .package(url: "https://github.com/huggingface/swift-transformers.git", revision: "e5e227b"),
        .package(url: "https://github.com/huggingface/swift-huggingface.git", from: "0.8.1"),
    ],
    targets: [
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
            name: "IntegrationTests",
            dependencies: [
                "MLXLMTransformers",
                "TestHelpers",
                .product(name: "HuggingFace", package: "swift-huggingface"),
                .product(name: "IntegrationTestHelpers", package: "mlx-swift-lm"),
            ]
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
    ]
)
