//
//  Build.swift
//  Bootstrap
//

import CommandLine

internal func build(_ bootstrapDirectory: String, _ flags: [String]) {
	let task = AutoTask(bootstrapDirectory + "/build", arguments: flags)
	task > StandardOut
}
