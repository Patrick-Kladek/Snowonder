//
//  main.swift
//  cli
//
//  Created by Patrick Kladek on 14.11.21.
//  Copyright © 2021 Karetski. All rights reserved.
//

import ArgumentParser
import Foundation

struct Snowonder: ParsableCommand {

    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to lint imports in Obj-C files",
        subcommands: [File.self, Folder.self])

    init() { }
}

Snowonder.main()
