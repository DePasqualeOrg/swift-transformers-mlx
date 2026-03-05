import BenchmarkHelpers
import HuggingFace
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
}
