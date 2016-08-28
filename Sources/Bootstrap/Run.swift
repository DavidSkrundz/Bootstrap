//
//  Run.swift
//  Bootstrap
//

import CommandLine
import LibC

internal func run(_ bootstrapPath: String, _ argument: String) {
	var arguments = [String]()
	
	arguments += platformArguments()
	arguments += moduleArguments(bootstrapPath)
	arguments += [argument]
	
	let task = AutoTask("swift", arguments: arguments)
	task > StandardOut
}

private func platformArguments() -> [String] {
#if os(macOS)
	// Hardcode 10.10 for now since `swift build` targets 10.10
	return ["-target", "x86_64-apple-macosx10.10"]
#endif
	
#if os(Linux)
	return []
#endif
}

private func moduleArguments(_ bootstrapPath: String) -> [String] {
	let modulesPath = bootstrapPath + "/../Modules"
	
	var listedModules = ""
	[
		"ls",
		"-1",
		modulesPath,
	] > listedModules
	
	return listedModules
		.components(separatedBy: "\n")
		.dropLast()
		.map { modulesPath + PathSeparator + $0 }
		.flatMap(moduleArgument)
}

private func moduleArgument(_ modulePath: String) -> [String] {
	let currentDirectory = Directory.CurrentDirectory()
	do {
		try Directory.ChangeDirectory(to: modulePath)
	} catch let error {
		print("Could not find module at \(modulePath) - \(error)")
		return []
	}
	defer { try! Directory.ChangeDirectory(to: currentDirectory) }
	
	var files = ""
	"ls -1" > files
	
	if files.contains("module.modulemap") {
		return [
			"-I" + modulePath,
		]
	} else {
		let importDirectoryFlag = "-I" + modulePath + "/.build/release"
		let linkDirectoryFlag = "-L" + modulePath + "/.build/release"
		let module = modulePath.components(separatedBy: PathSeparator).last
		let linkFlag = "-l" + (module ?? "")
		return [
			importDirectoryFlag,
			linkDirectoryFlag,
			linkFlag,
		]
	}
}
