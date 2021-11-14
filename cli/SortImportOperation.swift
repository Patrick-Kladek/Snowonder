//
//  SortImportOperation.swift
//  cli
//
//  Created by Patrick Kladek on 14.11.21.
//  Copyright © 2021 Karetski. All rights reserved.
//

import Foundation
import ImportArtisan

class SortImportOperation: Operation {

    let file: URL

    init(file: URL) {
        self.file = file
        super.init()
    }

    // MARK: - SortImportOperation

    override func main() {
        var encoding: String.Encoding = .utf8
        do {
            let string = try String(contentsOf: self.file, usedEncoding: &encoding)
            let lines = string.lines

            let detector = ImportBlockDetector()
            let importBlock = try detector.importBlock(from: lines)
            let formatter = ImportBlockFormatter()
            let formattedImportLines = formatter.lines(for: importBlock, using: ImportBlockFormatter.Operation.all)

            let bufferEditor = TextBufferEditor(lines: NSMutableArray(array: lines))
            bufferEditor.replace(lines: importBlock.declarations, with: formattedImportLines, using: .top)

            let formattedString = bufferEditor.lines.componentsJoined(by: "\n").appending("\n")
            try formattedString.write(to: self.file, atomically: true, encoding: encoding)
        } catch {
            print(error)
        }

        print(self.file.path)
    }
}
