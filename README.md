# Swift Transformers MLX

This package allows [Swift Transformers](https://github.com/huggingface/swift-transformers) to seamlessly integrate with [MLX Swift LM](https://github.com/ml-explore/mlx-swift-lm) by providing protocol conformance and convenience overloads.

Refer to the [Benchmarks](#Benchmarks) section to compare the performance of Swift Transformers and Swift Tokenizers.

It provides two modules:

- `MLXLMTransformers` for LLM and VLM loading
- `MLXEmbeddersTransformers` for embedding model loading

## Setup

Add this package alongside MLX Swift LM in your `Package.swift`:

```swift
.package(url: "https://github.com/DePasqualeOrg/swift-transformers-mlx/", from: "0.1.0"),
```

And add the modules you need to your target's dependencies:

```swift
.product(name: "MLXLMTransformers", package: "swift-transformers-mlx"),
// and/or
.product(name: "MLXEmbeddersTransformers", package: "swift-transformers-mlx"),
```

## Usage

`MLXLMTransformers` provides convenience overloads with a default tokenizer loader, so you can omit the `using:` parameter:

```swift
import MLXLLM
import MLXLMHuggingFace
import MLXLMTransformers

// TransformersLoader is used automatically
let model = try await loadModel(
    from: HubClient.default,
    id: "mlx-community/Qwen3-4B-4bit"
)
```

Load from a local directory:

```swift
import MLXLLM
import MLXLMTransformers

let container = try await loadModelContainer(from: modelDirectory)
```

You can also pass `TransformersLoader()` explicitly to the core API:

```swift
let container = try await loadModelContainer(
    from: HubClient.default,
    using: TransformersLoader(),
    id: "mlx-community/Qwen3-4B-4bit"
)
```

For embedders, import `MLXEmbeddersTransformers` to get the same default tokenizer behavior:

```swift
import MLXEmbedders
import MLXEmbeddersHuggingFace
import MLXEmbeddersTransformers

let container = try await loadModelContainer(
    from: HubClient.default,
    configuration: .nomic_text_v1_5
)
```

## Testing

Integration tests for inference and benchmarks are included.

## Benchmarks

The benchmarks use tests from MLX Swift LM and can be run from this package in Xcode.

These results were observed on an M3 MacBook Pro.

| Benchmark | Swift Tokenizers median | Swift Transformers median | Swift Transformers Performance |
| --- | ---: | ---: | --- |
| Tokenizer load | 289.6 ms | 1004.6 ms | 3.47x slower |
| Tokenization | 53.0 ms | 105.8 ms | 2.00x slower |
| Decoding | 28.9 ms | 48.4 ms | 1.67x slower |
| LLM load | 318.8 ms | 1033.5 ms | 3.24x slower |
| VLM load | 367.9 ms | 1081.5 ms | 2.94x slower |
| Embedding load | 310.7 ms | 1023.5 ms | 3.29x slower |
