//
//  Sugar.swift
//  cli
//
//  Created by Patrick Kladek on 14.11.21.
//  Copyright © 2021 Karetski. All rights reserved.
//

import Foundation

extension String {
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}

extension FileManager {

    func contents(of folder: URL, recursive: Bool = false) -> [URL] {
        var files = [URL]()

        var options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsPackageDescendants]
        if recursive == false {
            options.insert(.skipsSubdirectoryDescendants)
        }

        if let enumerator = self.enumerator(at: folder, includingPropertiesForKeys: [.isRegularFileKey], options: options) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        let supportedFileExtensions = ["m", "c", "h", "swift"]
                        if supportedFileExtensions.contains(fileURL.pathExtension) {
                            files.append(fileURL)
                        }
                    }
                } catch {
                    print(error, fileURL)
                }
            }
        }
        return files
    }
}

func measureTime(_ block: () -> Void) {
    let date = Date()

    block()

    let completed = Date()
    let totalTime = completed.timeIntervalSince(date)
    print("Finshed in \(String(format: "%.0f", totalTime*1000)) ms")
}
