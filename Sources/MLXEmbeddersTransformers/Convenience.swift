import Foundation
import MLXEmbedders
import MLXLMCommon
import MLXLMTransformers

/// Load an embedding model using ``TransformersLoader`` for tokenization.
public func load(
    from downloader: any Downloader,
    configuration: MLXEmbedders.ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> (EmbeddingModel, Tokenizer) {
    try await MLXEmbedders.load(
        from: downloader, using: TransformersLoader(), configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load an embedding model container using ``TransformersLoader`` for tokenization.
public func loadModelContainer(
    from downloader: any Downloader,
    configuration: MLXEmbedders.ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> MLXEmbedders.ModelContainer {
    try await MLXEmbedders.loadModelContainer(
        from: downloader, using: TransformersLoader(), configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load an embedding model from a local directory using ``TransformersLoader``
/// for tokenization.
public func load(
    from directory: URL
) async throws -> (EmbeddingModel, Tokenizer) {
    try await MLXEmbedders.load(from: directory, using: TransformersLoader())
}

/// Load an embedding model container from a local directory using
/// ``TransformersLoader`` for tokenization.
public func loadModelContainer(
    from directory: URL
) async throws -> MLXEmbedders.ModelContainer {
    try await MLXEmbedders.loadModelContainer(from: directory, using: TransformersLoader())
}
