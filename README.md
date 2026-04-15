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
    configuration: EmbedderRegistry.qwen3_embedding
)
```

## Testing

Benchmarks are included by default. Integration tests are opt-in and download models from Hugging Face on first run. The integration suite stays at roughly 5 GB or less per repository to avoid RAM issues on lower-memory devices.

### Running integration tests

In Xcode, set `TRANSFORMERS_MLX_ENABLE_INTEGRATION_TESTS=1` in the test scheme environment.

From the command line, run MLX-backed tests with `xcodebuild` and the test-runner passthrough variable:

```bash
TEST_RUNNER_TRANSFORMERS_MLX_ENABLE_INTEGRATION_TESTS=1 \
  xcodebuild test -scheme swift-transformers-mlx-Package -destination 'platform=macOS,arch=arm64' -only-testing:IntegrationTests
```

## Benchmarks

| | Swift Transformers | Swift Tokenizers | |
| --- | ---: | ---: | --- |
| Tokenizer load | 399.3 ms | 177.5 ms | 2.2x faster |
| Tokenization | 48.4 ms | 23.7 ms | 2.0x faster |
| Decoding | 30.9 ms | 15.7 ms | 2.0x faster |
| LLM load | 409.7 ms | 197.4 ms | 2.1x faster |
| VLM load | 441.6 ms | 223.2 ms | 2.0x faster |
| Embedding load | 412.0 ms | 193.8 ms | 2.1x faster |

These results were observed on an M3 MacBook Pro using Swift Tokenizers [`0.3.1`](https://github.com/DePasqualeOrg/swift-tokenizers/releases/tag/0.3.1), Swift Transformers [`1.3.0`](https://github.com/huggingface/swift-transformers/releases/tag/1.3.0), and MLX Swift LM `8c9dd63`.

### Running benchmarks

The benchmarks use tests from MLX Swift LM and can be run from this package in Xcode or from the command line with `xcodebuild`:

```bash
xcodebuild test -scheme swift-transformers-mlx-Package -configuration Release -destination 'platform=macOS,arch=arm64' -only-testing:Benchmarks
```
