//
//  Install.swift
//  Bootstrap
//

import CommandLine

internal func install(_ bootstrapDirectory: String, _ flags: [String]) {
	let task = AutoTask(cmd: bootstrapDirectory + "/install", args: flags)
	task > standardOut
}
