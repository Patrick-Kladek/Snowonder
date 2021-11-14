//
//  main.swift
//  cli
//
//  Created by Patrick Kladek on 14.11.21.
//  Copyright © 2021 Karetski. All rights reserved.
//

import ArgumentParser
import Foundation
import ImportArtisan


struct File: ParsableCommand {

    @Argument(help: "file in which imports are sorted", completion: .file(), transform: URL.init(fileURLWithPath:))
    var file: URL

    mutating func run() throws {
        measureTime {
            let operation = SortImportOperation(file: self.file)
            operation.start()
        }
    }
}
