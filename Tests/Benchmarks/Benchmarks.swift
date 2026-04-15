import BenchmarkHelpers
import HuggingFace
import MLXEmbedders
import MLXEmbeddersTransformers
import MLXLMTransformers
import TestHelpers
import Testing

@Suite(.serialized)
struct Benchmarks {
    @Test func loadTokenizer() async throws {
        let stats = try await benchmarkTokenizerLoading(
            from: HubClient.default,
            using: TransformersLoader()
        )
        stats.printSummary(label: "Tokenizer load (swift-transformers)")
    }

    @Test func tokenizeText() async throws {
        let sampleText = try await loadTokenizationBenchmarkText()
        let stats = try await benchmarkTokenization(
            from: HubClient.default,
            using: TransformersLoader(),
            text: sampleText
        )
        stats.printSummary(label: "Tokenization (swift-transformers)")
    }

    @Test func decodeText() async throws {
        let sampleText = try await loadDecodingBenchmarkText()
        let stats = try await benchmarkDecoding(
            from: HubClient.default,
            using: TransformersLoader(),
            text: sampleText
        )
        stats.printSummary(label: "Decoding (swift-transformers)")
    }

    @Test func loadLLM() async throws {
        let stats = try await benchmarkLLMLoading(
            from: HubClient.default,
            using: TransformersLoader()
        )
        stats.printSummary(label: "LLM load (swift-transformers)")
    }

    @Test func loadVLM() async throws {
        let stats = try await benchmarkVLMLoading(
            from: HubClient.default,
            using: TransformersLoader()
        )
        stats.printSummary(label: "VLM load (swift-transformers)")
    }

    @Test func loadEmbedding() async throws {
        let stats = try await benchmarkEmbeddingLoading(
            from: HubClient.default,
            using: TransformersLoader()
        )
        stats.printSummary(label: "Embedding load (swift-transformers)")
    }

    @Test func embeddingConvenience() async throws {
        let config = EmbedderRegistry.bge_micro
        let hub = HubClient.default

        // Free function loadModelContainer (downloader, default TransformersLoader)
        let container = try await MLXEmbeddersTransformers.loadModelContainer(
            from: hub, configuration: config)
        let modelDirectory = try await container.modelDirectory

        // Free function loadModel (downloader)
        _ = try await MLXEmbeddersTransformers.loadModel(
            from: hub, configuration: config)

        // Free function loadModelContainer (directory)
        _ = try await MLXEmbeddersTransformers.loadModelContainer(from: modelDirectory)

        // Free function loadModel (directory)
        _ = try await MLXEmbeddersTransformers.loadModel(from: modelDirectory)

        // EmbedderModelFactory extension loadContainer (downloader, default TransformersLoader)
        _ = try await EmbedderModelFactory.shared.loadContainer(
            from: hub, configuration: config)

        // EmbedderModelFactory extension load (downloader)
        _ = try await EmbedderModelFactory.shared.load(
            from: hub, configuration: config)

        // EmbedderModelFactory extension loadContainer (directory)
        _ = try await EmbedderModelFactory.shared.loadContainer(from: modelDirectory)

        // EmbedderModelFactory extension load (directory)
        _ = try await EmbedderModelFactory.shared.load(from: modelDirectory)
    }
}
