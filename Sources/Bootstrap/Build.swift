//
//  Build.swift
//  Bootstrap
//

import CommandLine

internal func build(_ bootstrapDirectory: String, _ flags: [String]) {
	let task = AutoTask(cmd: bootstrapDirectory + "/bin/build", args: flags)
	task > standardOut
}
