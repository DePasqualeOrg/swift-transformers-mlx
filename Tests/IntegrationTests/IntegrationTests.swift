import HuggingFace
import IntegrationTestHelpers
import MLXLMTransformers
import TestHelpers
import Testing

private let models = IntegrationTestModels(
    downloader: HubClient.default, tokenizerLoader: TransformersLoader())

@Suite(.serialized)
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

    @Test func glm4FormatAutoDetection() async throws {
        try await ToolCallTests.glm4FormatAutoDetection(container: models.glm4Container())
    }

    @Test func glm4EndToEndGeneration() async throws {
        try await ToolCallTests.glm4EndToEndGeneration(container: models.glm4Container())
    }
}
