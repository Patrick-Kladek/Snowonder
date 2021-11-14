//
//  TextBufferEditor.swift
//  cli
//
//  Created by Patrick Kladek on 14.11.21.
//  Copyright © 2021 Karetski. All rights reserved.
//

import Foundation

class TextBufferEditor {

    private(set) var lines: NSMutableArray

    init(lines: NSMutableArray) {
        self.lines = lines
    }

    enum ReplacementOption {
        case top
        case bottom
        // TODO: Add `direct` case to replace line by line
    }

    func replace(lines: [String], with newLines: [String], using option: ReplacementOption) {
        let replacementStartIndex: Int = {
            switch option {
            case .top:
                return self.lines.index(of: lines.first ?? "")
            case .bottom:
                return self.lines.index(of: lines.last ?? "")
            }
        }()

        guard replacementStartIndex != NSNotFound else { return }

        let newLinesIndexSet = IndexSet(integersIn: replacementStartIndex ..< replacementStartIndex + newLines.count)
        self.lines.removeObjects(in: lines)
        self.lines.insert(newLines, at: newLinesIndexSet)
    }
}
