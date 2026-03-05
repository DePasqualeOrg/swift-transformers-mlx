import Foundation
import HuggingFace
import MLXEmbedders
import MLXLMCommon
import MLXLMTransformers

// MARK: - Convenience overloads defaulting to HubClient.default

/// Load an embedding model using the default Hugging Face Hub client.
public func load(
    from hub: HubClient = .default,
    using tokenizerLoader: any TokenizerLoader,
    configuration: MLXEmbedders.ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> (EmbeddingModel, Tokenizer) {
    try await MLXEmbedders.load(
        from: hub,
        using: tokenizerLoader,
        configuration: configuration,
        useLatest: useLatest,
        progressHandler: progressHandler
    )
}

/// Load an embedding model container using the default Hugging Face Hub client.
public func loadModelContainer(
    from hub: HubClient = .default,
    using tokenizerLoader: any TokenizerLoader,
    configuration: MLXEmbedders.ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> MLXEmbedders.ModelContainer {
    try await MLXEmbedders.loadModelContainer(
        from: hub,
        using: tokenizerLoader,
        configuration: configuration,
        useLatest: useLatest,
        progressHandler: progressHandler
    )
}
