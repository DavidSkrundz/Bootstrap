//
//  Build.swift
//  Bootstrap
//

import CommandLine
import LibC

private let Reset = ANSIForegroundColor.Default
private let Green = ANSIForegroundColor.Green

internal func build(_ argument: String, _ flags: [String]) {
	switch argument {
		case "--all":
			buildAll(flags: flags)
		default:
			build(module: argument, flags: flags)
	}
}

internal func buildAll(flags: [String]) {
	var listedModules = ""
	"ls -1 ../../Modules/" > listedModules
	
	let modules = listedModules
		.components(separatedBy: "\n")
		.dropLast()
	
	for module in modules {
		build(module: module, flags: flags)
	}
}

internal func build(module: String, flags: [String]) {
	let currentDirectory = Directory.CurrentDirectory()
	do {
		try Directory.ChangeDirectory(to: "../../Modules/\(module)")
	} catch let error {
		print("Could not find module \(module) - \(error)")
		return
	}
	
	if flags.count > 0 && (flags.contains("-u") || flags.contains("--update")) {
		print(Green + "Updating \(module)..." + Reset)
		update()
	}
	
	print(Green + "Building \(module)..." + Reset)
	
	var files = ""
	"ls -1" > files
	
	if !files.contains("module.modulemap") {
		"swift package update" > StandardOut
		"swift build --configuration release" > StandardOut
	}
	
	try! Directory.ChangeDirectory(to: currentDirectory)
}

private func update() {
	"git remote update" > StandardOut
	
	var local = ""
	var remote = ""
	"git rev-parse @" > local
	"git rev-parse @{u}" > remote
	
	if local == remote {
		print(Green + "Up-to-date" + Reset)
		return
	}
	
	"git clean -fxd --exclude=/$TMP_INSTALL" > StandardOut
	"git reset --hard origin/master" > StandardOut
	print(Green + "Updated" + Reset)
}
