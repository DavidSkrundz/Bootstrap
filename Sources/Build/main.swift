//
//  main.swift
//  Bootstrap
//

import CommandLine
import Foundation
import LibC

internal let pathSeparator = "/"

private func main(_ path: String, _ arguments: [String]) {
	guard arguments.count == 1 || arguments.count == 2 else {
		usage()
		return
	}
	
	let flags = Array(arguments.dropLast())
	for flag in flags {
		if flag != "-u" && flag != "--update" {
			usage()
			return
		}
	}
	
	let currentDirectory = Directory.current()
	try! Directory.change(to: path)
	
	build(arguments.last!, flags)
	fixPermissions()
	
	try! Directory.change(to: currentDirectory)
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


disablePrintBuffering()

let process = ProcessInfo.processInfo
let environment = process.environment
let arguments = process.arguments

guard let bootstrapPath = environment["BOOTSTRAP_PATH"] else {
	fatalError("Environment variable BOOTSTRAP_PATH not set")
}
let actualArguments = Array(arguments.dropFirst())

main(bootstrapPath, actualArguments)
