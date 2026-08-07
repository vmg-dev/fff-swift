import Foundation
import XCTest
@testable import FFFKit

final class FFFIndexTests: XCTestCase {
    func testIndexesFilesAndAncestorDirectories() async throws {
        let fileManager = FileManager.default
        let root = fileManager.temporaryDirectory
            .appendingPathComponent("FFFKitTests-\(UUID().uuidString)", isDirectory: true)
        let nested = root.appendingPathComponent("Projects/Floodlight", isDirectory: true)
        let file = nested.appendingPathComponent("search-notes.txt")
        let storage = root.appendingPathComponent(".index", isDirectory: true)
        try fileManager.createDirectory(at: nested, withIntermediateDirectories: true)
        try Data("fast local search".utf8).write(to: file)
        defer { try? fileManager.removeItem(at: root) }

        let index = FFFIndex(
            rootURL: root,
            storageURL: storage,
            enableContentIndexing: false,
            watch: false
        )
        try await index.start()

        for _ in 0..<200 {
            if try await !index.progress().isScanning {
                break
            }
            try await Task.sleep(for: .milliseconds(10))
        }

        let files = try await index.searchFiles("search-notes")
        XCTAssertTrue(files.contains { $0.url.standardizedFileURL == file.standardizedFileURL })

        let folders = try await index.searchDirectories("Projects")
        XCTAssertTrue(
            folders.contains {
                $0.url.standardizedFileURL
                    == root.appendingPathComponent("Projects").standardizedFileURL
            }
        )
    }

    func testCanExcludeBinaryFilesFromFilenameIndex() async throws {
        let fileManager = FileManager.default
        let root = fileManager.temporaryDirectory
            .appendingPathComponent("FFFKitTests-\(UUID().uuidString)", isDirectory: true)
        let textFile = root.appendingPathComponent("notes.txt")
        let binaryFile = root.appendingPathComponent("photo.png")
        let storage = root.appendingPathComponent(".index", isDirectory: true)
        try fileManager.createDirectory(at: root, withIntermediateDirectories: true)
        try Data("searchable text".utf8).write(to: textFile)
        try Data([0x89, 0x50, 0x4E, 0x47]).write(to: binaryFile)
        defer { try? fileManager.removeItem(at: root) }

        let index = FFFIndex(
            rootURL: root,
            storageURL: storage,
            enableContentIndexing: false,
            includeBinaryFiles: false,
            watch: false
        )
        try await index.start()

        for _ in 0..<200 {
            if try await !index.progress().isScanning {
                break
            }
            try await Task.sleep(for: .milliseconds(10))
        }

        let textResults = try await index.searchFiles("notes")
        let binaryResults = try await index.searchFiles("photo")
        XCTAssertTrue(
            textResults.contains { $0.url.standardizedFileURL == textFile.standardizedFileURL }
        )
        XCTAssertFalse(
            binaryResults.contains { $0.url.standardizedFileURL == binaryFile.standardizedFileURL }
        )
    }
}
