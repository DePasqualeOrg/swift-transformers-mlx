import Foundation
import HuggingFace
import MLXLMCommon

// MARK: - ModelFactory convenience overloads

extension ModelFactory {

    /// Load a model using the default Hugging Face Hub client and ``TransformersLoader``.
    public func load(
        from hub: HubClient = .default,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> sending ModelContext {
        try await load(
            from: hub as any Downloader, using: TransformersLoader(),
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load a model container using the default Hugging Face Hub client and ``TransformersLoader``.
    public func loadContainer(
        from hub: HubClient = .default,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> ModelContainer {
        try await loadContainer(
            from: hub as any Downloader, using: TransformersLoader(),
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load a model using the default Hugging Face Hub client.
    public func load(
        from hub: HubClient = .default,
        using tokenizerLoader: any TokenizerLoader,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> sending ModelContext {
        try await load(
            from: hub as any Downloader, using: tokenizerLoader,
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load a model container using the default Hugging Face Hub client.
    public func loadContainer(
        from hub: HubClient = .default,
        using tokenizerLoader: any TokenizerLoader,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> ModelContainer {
        try await loadContainer(
            from: hub as any Downloader, using: tokenizerLoader,
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load a model using ``TransformersLoader`` for tokenization.
    public func load(
        from downloader: any Downloader,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> sending ModelContext {
        try await load(
            from: downloader, using: TransformersLoader(),
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load a model container using ``TransformersLoader`` for tokenization.
    public func loadContainer(
        from downloader: any Downloader,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> ModelContainer {
        try await loadContainer(
            from: downloader, using: TransformersLoader(),
            configuration: configuration,
            useLatest: useLatest, progressHandler: progressHandler)
    }

    /// Load a model from a local directory using ``TransformersLoader``.
    public func load(
        from directory: URL
    ) async throws -> sending ModelContext {
        try await load(from: directory, using: TransformersLoader())
    }

    /// Load a model container from a local directory using ``TransformersLoader``.
    public func loadContainer(
        from directory: URL
    ) async throws -> ModelContainer {
        try await loadContainer(from: directory, using: TransformersLoader())
    }
}

// MARK: - Free function convenience overloads

/// Load a model using the default Hugging Face Hub client and ``TransformersLoader``.
public func loadModel(
    from hub: HubClient = .default,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(
        from: hub, using: TransformersLoader(), configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model container using the default Hugging Face Hub client and ``TransformersLoader``.
public func loadModelContainer(
    from hub: HubClient = .default,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContainer {
    try await MLXLMCommon.loadModelContainer(
        from: hub, using: TransformersLoader(), configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model using the default Hugging Face Hub client.
public func loadModel(
    from hub: HubClient = .default,
    using tokenizerLoader: any TokenizerLoader,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(
        from: hub, using: tokenizerLoader, configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model container using the default Hugging Face Hub client.
public func loadModelContainer(
    from hub: HubClient = .default,
    using tokenizerLoader: any TokenizerLoader,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContainer {
    try await MLXLMCommon.loadModelContainer(
        from: hub, using: tokenizerLoader, configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model using ``TransformersLoader`` for tokenization.
public func loadModel(
    from downloader: any Downloader,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(
        from: downloader, using: TransformersLoader(), configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model container using ``TransformersLoader`` for tokenization.
public func loadModelContainer(
    from downloader: any Downloader,
    configuration: ModelConfiguration,
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContainer {
    try await MLXLMCommon.loadModelContainer(
        from: downloader, using: TransformersLoader(), configuration: configuration,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model by ID using the default Hugging Face Hub client and ``TransformersLoader``.
public func loadModel(
    from hub: HubClient = .default,
    id: String,
    revision: String = "main",
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(
        from: hub, using: TransformersLoader(), id: id, revision: revision,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model container by ID using the default Hugging Face Hub client and ``TransformersLoader``.
public func loadModelContainer(
    from hub: HubClient = .default,
    id: String,
    revision: String = "main",
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContainer {
    try await MLXLMCommon.loadModelContainer(
        from: hub, using: TransformersLoader(), id: id, revision: revision,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model by ID using the default Hugging Face Hub client.
public func loadModel(
    from hub: HubClient = .default,
    using tokenizerLoader: any TokenizerLoader,
    id: String,
    revision: String = "main",
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(
        from: hub, using: tokenizerLoader, id: id, revision: revision,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model container by ID using the default Hugging Face Hub client.
public func loadModelContainer(
    from hub: HubClient = .default,
    using tokenizerLoader: any TokenizerLoader,
    id: String,
    revision: String = "main",
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContainer {
    try await MLXLMCommon.loadModelContainer(
        from: hub, using: tokenizerLoader, id: id, revision: revision,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model by ID using ``TransformersLoader`` for tokenization.
public func loadModel(
    from downloader: any Downloader,
    id: String,
    revision: String = "main",
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(
        from: downloader, using: TransformersLoader(), id: id, revision: revision,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model container by ID using ``TransformersLoader`` for tokenization.
public func loadModelContainer(
    from downloader: any Downloader,
    id: String,
    revision: String = "main",
    useLatest: Bool = false,
    progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
) async throws -> sending ModelContainer {
    try await MLXLMCommon.loadModelContainer(
        from: downloader, using: TransformersLoader(), id: id, revision: revision,
        useLatest: useLatest, progressHandler: progressHandler)
}

/// Load a model from a local directory using ``TransformersLoader``.
public func loadModel(
    from directory: URL
) async throws -> sending ModelContext {
    try await MLXLMCommon.loadModel(from: directory, using: TransformersLoader())
}

/// Load a model container from a local directory using ``TransformersLoader``.
public func loadModelContainer(
    from directory: URL
) async throws -> ModelContainer {
    try await MLXLMCommon.loadModelContainer(from: directory, using: TransformersLoader())
}

// MARK: - ModelAdapterFactory convenience overload

extension ModelAdapterFactory {

    /// Load an adapter using the default Hugging Face Hub client.
    public func load(
        from hub: HubClient = .default,
        configuration: ModelConfiguration,
        useLatest: Bool = false,
        progressHandler: @Sendable @escaping (Progress) -> Void = { _ in }
    ) async throws -> ModelAdapter {
        try await load(
            from: hub as any Downloader,
            configuration: configuration,
            useLatest: useLatest,
            progressHandler: progressHandler
        )
    }
}
