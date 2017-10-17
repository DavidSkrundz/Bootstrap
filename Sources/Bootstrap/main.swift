//
//  main.swift
//  Bootstrap
//

import Foundation
import LibC

internal let pathSeparator = "/"

private func main(_ path: String, _ arguments: [String]) {
	let bootstrapDirectory = path
		.components(separatedBy: pathSeparator)
		.dropLast(1)
		.joined(separator: pathSeparator)
	
	if arguments.count >= 1 && arguments[0].hasPrefix("-") {
		runMode(bootstrapDirectory,
		        arguments[0],
		        Array(arguments.dropFirst()))
	} else if arguments.count == 1 {
		run(bootstrapDirectory, arguments[0])
	} else {
		usage()
	}
}

private func runMode(_ path: String, _ mode: String, _ flags: [String]) {
	switch mode {
		case "-b", "--build":
			build(path, flags)
		case "-i", "--install":
			install(path, flags)
		default:
			usage()
	}
}

let process = ProcessInfo.processInfo
let environment = process.environment
let arguments = process.arguments

guard let bootstrapPath = environment["BOOTSTRAP_PATH"] else {
	fatalError("Environment variable BOOTSTRAP_PATH not set")
}
let actualArguments = Array(arguments.dropFirst())
	
main(bootstrapPath, actualArguments)
