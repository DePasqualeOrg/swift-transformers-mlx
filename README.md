# Swift Transformers MLX

This package allows [Swift Transformers](https://github.com/huggingface/swift-transformers) to seamlessly integrate with [MLX Swift LM](https://github.com/ml-explore/mlx-swift-lm) by providing protocol conformance and convenience overloads.

## Setup

Add this package alongside mlx-swift-lm in your `Package.swift`:

```swift
.package(url: "https://github.com/DePasqualeOrg/swift-transformers-mlx/", from: "0.1.0"),
```

And add `MLXLMTransformers` to your target's dependencies:

```swift
.product(name: "MLXLMTransformers", package: "swift-transformers-mlx"),
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

## Re-exports

`MLXLMTransformers` re-exports `MLXLMCommon`, so you get access to the full mlx-swift-lm API without an additional import.

## Testing

Integration tests for inference and benchmarks for model loading are included.
