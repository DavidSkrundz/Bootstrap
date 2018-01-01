//
//  main.swift
//  Bootstrap
//

import CommandLine
import Foundation
import LibC

internal let pathSeparator = "/"

private func main(_ bootstrapPath: String) throws {
	disablePrintBuffering()
	
	var shouldUpdate = false
	var shouldBuildAll = false
	
	let parser = ArgumentParser(strict: true)
	parser.boolOption(long: "all",
					  description: "Build all modules") {
						shouldBuildAll = $0
	}
	parser.boolOption(short: "u", long: "update",
					  description: "Fetch the latest commit before building") {
						shouldUpdate = $0
	}
	parser.boolOption(short: "h", long: "help",
					  description: "Print this help message") { _ in
						usage(parser)
						
	}
	
	let arguments = try parser.parse()
	
	if arguments.isEmpty && !shouldBuildAll {
		print("No module specified")
		exit(1)
	}
	
	let currentDirectory = Directory.current()
	try Directory.change(to: bootstrapPath)

	if shouldBuildAll {
		buildAll(shouldUpdate: shouldUpdate)
	} else {
		for module in arguments {
			build(module: module, shouldUpdate: shouldUpdate)
		}
	}
	fixPermissions()

	try Directory.change(to: currentDirectory)
}

private func fixPermissions() {
	"chmod -R 755 ../../Modules/" > standardOut
}

private func disablePrintBuffering() {
	// Without this nothing would get printed until the builds are done
	
	#if os(macOS)
		setvbuf(__stdoutp, nil, _IOLBF, 0)
	#endif
	
	#if os(Linux)
		setvbuf(stdout, nil, _IOLBF, 0)
	#endif
}

let environment = ProcessInfo.processInfo.environment
guard let bootstrapPath = environment["BOOTSTRAP_PATH"] else {
	let Reset = ANSI.Text.Color.Default
	let Red = ANSI.Text.Color.Red
	print(Red + "Environment variable BOOTSTRAP_PATH not set" + Reset)
	exit(-1)
}
do {
	try main("bootstrapPath")
} catch let error as ParseError {
	print(error.description)
} catch let e {
	print(e.localizedDescription)
}
