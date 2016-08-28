//
//  main.swift
//  Bootstrap
//

import Foundation
import LibC
import UnicodeOperators
import Util

internal let PathSeparator = "/"

private func main(_ path: String, _ arguments: [String]) {
	guard arguments.count == 1 || arguments.count == 2 else {
		usage()
		return
	}
	
	let flags = arguments.dropLast().toArray()
	for flag in flags {
		if flag ≠ "-u" && flag ≠ "--update" {
			usage()
			return
		}
	}
	
	let currentDirectory = Directory.CurrentDirectory()
	try! Directory.ChangeDirectory(to: path)
	
	build(arguments.last!, flags)
	
	try! Directory.ChangeDirectory(to: currentDirectory)
}

// Disable output buffering, otherwise when bootstrap runs build, nothing will
// print until build has completed
#if os(macOS)
	setvbuf(__stdoutp, nil, _IOLBF, 0)
#endif

#if os(Linux)
	setvbuf(stdout, nil, _IOLBF, 0)
#endif

let process = ProcessInfo.processInfo
let environment = process.environment
let arguments = process.arguments

guard let bootstrapPath = environment["BOOTSTRAP_PATH"] else {
	fatalError("Environment variable BOOTSTRAP_PATH not set")
}
let actualArguments = arguments.dropFirst().toArray()

main(bootstrapPath, actualArguments)
