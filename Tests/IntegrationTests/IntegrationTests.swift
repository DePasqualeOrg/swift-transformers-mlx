import Foundation
import HuggingFace
import IntegrationTestHelpers
import MLXLMTransformers
import TestHelpers
import Testing

private let integrationTestsEnabled =
    ProcessInfo.processInfo.environment["TRANSFORMERS_MLX_ENABLE_INTEGRATION_TESTS"] == "1"

private let models = IntegrationTestModels(
    downloader: HubClient.default, tokenizerLoader: TransformersLoader())

@Suite(.serialized, .enabled(if: integrationTestsEnabled))
struct IntegrationTests {

    // MARK: - ChatSession

    @Test func oneShot() async throws {
        try await ChatSessionTests.oneShot(container: models.llmContainer())
    }

    @Test func oneShotStream() async throws {
        try await ChatSessionTests.oneShotStream(container: models.llmContainer())
    }

    @Test func multiTurnConversation() async throws {
        try await ChatSessionTests.multiTurnConversation(container: models.llmContainer())
    }

    @Test func visionModel() async throws {
        try await ChatSessionTests.visionModel(container: models.vlmContainer())
    }

    @Test func streamDetailsWithTools() async throws {
        try await ChatSessionTests.streamDetailsWithTools(container: models.llmContainer())
    }

    @Test func toolInvocation() async throws {
        try await ChatSessionTests.toolInvocation(container: models.llmContainer())
    }

    @Test func promptRehydration() async throws {
        try await ChatSessionTests.promptRehydration(container: models.llmContainer())
    }

    // MARK: - Embedder

    @Test func embedderReadmeExample() async throws {
        try await EmbedderTests.readmeExample(container: models.embeddingContainer())
    }

    // MARK: - Tool Calls

    @Test func lfm2FormatAutoDetection() async throws {
        try await ToolCallTests.lfm2FormatAutoDetection(container: models.lfm2Container())
    }

    @Test func lfm2EndToEndGeneration() async throws {
        try await ToolCallTests.lfm2EndToEndGeneration(container: models.lfm2Container())
    }

    // Keep integration models at roughly 5 GB or less per repo.
    // Larger models can exhaust RAM and crash lower-memory devices during load or inference.

    @Test func mistral3FormatAutoDetection() async throws {
        try await ToolCallTests.mistral3FormatAutoDetection(container: models.mistral3Container())
    }

    @Test func mistral3EndToEndGeneration() async throws {
        try await ToolCallTests.mistral3EndToEndGeneration(container: models.mistral3Container())
    }

    @Test func mistral3MultiToolGeneration() async throws {
        try await ToolCallTests.mistral3MultiToolGeneration(container: models.mistral3Container())
    }

    @Test func qwen35FormatAutoDetection() async throws {
        try await ToolCallTests.qwen35FormatAutoDetection(container: models.qwen35Container())
    }

    @Test func qwen35EndToEndGeneration() async throws {
        try await ToolCallTests.qwen35EndToEndGeneration(container: models.qwen35Container())
    }

    @Test func qwen35MultiToolGeneration() async throws {
        try await ToolCallTests.qwen35MultiToolGeneration(container: models.qwen35Container())
    }
}
