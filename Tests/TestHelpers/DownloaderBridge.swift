import Foundation
import HuggingFace
import MLXLMCommon

enum DownloaderBridgeError: LocalizedError {
    case invalidRepositoryID(String)

    var errorDescription: String? {
        switch self {
        case .invalidRepositoryID(let id):
            return "Invalid Hugging Face repository ID: '\(id)'. Expected format 'namespace/name'."
        }
    }
}

// swift-format-ignore: AvoidRetroactiveConformances
extension HuggingFace.HubClient: @retroactive Downloader {
    public func download(
        id: String,
        revision: String?,
        matching patterns: [String],
        useLatest: Bool,
        progressHandler: @Sendable @escaping (Progress) -> Void
    ) async throws -> URL {
        guard let repoID = Repo.ID(rawValue: id) else {
            throw DownloaderBridgeError.invalidRepositoryID(id)
        }
        let revision = revision ?? "main"

        if !useLatest,
            let cached = try? await downloadSnapshot(
                of: repoID,
                revision: revision,
                matching: patterns,
                localFilesOnly: true,
                progressHandler: nil
            )
        {
            return cached
        }

        return try await downloadSnapshot(
            of: repoID,
            revision: revision,
            matching: patterns,
            localFilesOnly: false,
            progressHandler: { progress in progressHandler(progress) }
        )
    }
}
