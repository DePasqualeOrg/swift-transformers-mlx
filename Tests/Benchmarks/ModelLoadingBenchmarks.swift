import BenchmarkHelpers
import HuggingFace
import MLXLMTransformers
import Testing

@Suite(.serialized)
struct ModelLoadingBenchmarks {

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
