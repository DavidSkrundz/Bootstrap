//
//  Build.swift
//  Bootstrap
//

import CommandLine
import LibC

private let Reset = ANSI.Text.Color.Default
private let Green = ANSI.Text.Color.Green

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
	AutoTask("ls -1 ../../Modules/") > listedModules
	
	let modules = listedModules
		.components(separatedBy: "\n")
		.dropLast()
	
	for module in modules {
		build(module: module, flags: flags)
	}
}

internal func build(module: String, flags: [String]) {
	let currentDirectory = Directory.current()
	do {
		try Directory.change(to: "../../Modules/\(module)")
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
	AutoTask("ls -1") > files
	
	if !files.contains("module.modulemap") {
		"swift package update" > standardOut
		"swift build --configuration release" > standardOut
	}
	
	try! Directory.change(to: currentDirectory)
}

private func update() {
	"git remote update" > standardOut
	
	var local = ""
	var remote = ""
	AutoTask("git rev-parse @") > local
	AutoTask("git rev-parse @{u}") > remote
	
	if local == remote {
		print(Green + "Up-to-date" + Reset)
		return
	}
	
	"git clean -fxd --exclude=/$TMP_INSTALL" > standardOut
	"git reset --hard origin/master" > standardOut
	print(Green + "Updated" + Reset)
}
