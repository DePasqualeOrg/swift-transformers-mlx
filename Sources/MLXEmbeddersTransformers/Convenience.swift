import Foundation
import MLXEmbedders
import MLXLMCommon
import MLXLMTransformers

// MARK: - EmbedderModelFactory convenience overloads

extension EmbedderModelFactory {

    /// Load an embedding model using ``TransformersLoader`` for tokenization.
    public func load(
        from downloader: any Downloader,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> sending EmbedderModelContext {
        try await load(
            from: downloader, using: TransformersLoader(),
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load an embedding model container using ``TransformersLoader`` for tokenization.
    public func loadContainer(
        from downloader: any Downloader,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> EmbedderModelContainer {
        try await loadContainer(
            from: downloader, using: TransformersLoader(),
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load an embedding model from a local directory using ``TransformersLoader``
    /// for tokenization.
    public func load(
        from directory: URL
    ) async throws -> sending EmbedderModelContext {
        try await load(from: directory, using: TransformersLoader())
    }

    /// Load an embedding model container from a local directory using
    /// ``TransformersLoader`` for tokenization.
    public func loadContainer(
        from directory: URL
    ) async throws -> EmbedderModelContainer {
        try await loadContainer(from: directory, using: TransformersLoader())
    }
}

// MARK: - Free function convenience overloads

/// Load an embedding model using ``TransformersLoader`` for tokenization.
public func loadModel(
    from downloader: any Downloader,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending EmbedderModelContext {
    try await EmbedderModelFactory.shared.load(
        from: downloader, using: TransformersLoader(),
        configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load an embedding model container using ``TransformersLoader`` for tokenization.
public func loadModelContainer(
    from downloader: any Downloader,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> EmbedderModelContainer {
    try await EmbedderModelFactory.shared.loadContainer(
        from: downloader, using: TransformersLoader(),
        configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load an embedding model from a local directory using ``TransformersLoader``
/// for tokenization.
public func loadModel(
    from directory: URL
) async throws -> sending EmbedderModelContext {
    try await EmbedderModelFactory.shared.load(from: directory, using: TransformersLoader())
}

/// Load an embedding model container from a local directory using
/// ``TransformersLoader`` for tokenization.
public func loadModelContainer(
    from directory: URL
) async throws -> EmbedderModelContainer {
    try await EmbedderModelFactory.shared.loadContainer(from: directory, using: TransformersLoader())
}
