//
//  Install.swift
//  Bootstrap
//

import CommandLine

internal func install(_ bootstrapDirectory: String, _ flags: [String]) {
	let task = AutoTask(bootstrapDirectory + "/install", arguments: flags)
	task > StandardOut
}
