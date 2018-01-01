//
//  Usage.swift
//  Bootstrap
//

import CommandLine
import Foundation

internal func usage(_ parser: ArgumentParser) -> Never {
	print("OVERVIEW: Update and Build all modules in the Modules directory")
	print("")
	print("USAGE: build <options> [module...]")
	print("")
	print(parser.usage())
	exit(0)
}
