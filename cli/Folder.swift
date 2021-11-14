//
//  Folder.swift
//  cli
//
//  Created by Patrick Kladek on 14.11.21.
//  Copyright © 2021 Karetski. All rights reserved.
//

import ArgumentParser
import Foundation
import ImportArtisan


struct Folder: ParsableCommand {

    @Argument(help: "folder in which files will be linted", completion: .file(), transform: URL.init(fileURLWithPath:))
    var folder: URL

    mutating func run() throws {
        measureTime {
            let files = FileManager.default.contents(of: self.folder, recursive: true)
            let operationQueue = OperationQueue()
            operationQueue.progress.totalUnitCount = Int64(files.count)

            for file in files {
                operationQueue.addOperation(SortImportOperation(file: file))
            }
            operationQueue.waitUntilAllOperationsAreFinished()
        }
    }
}
