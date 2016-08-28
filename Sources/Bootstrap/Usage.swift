//
//  Usage.swift
//  Bootstrap
//

internal func usage() {
	print("OVERVIEW: Bootstrap .swift files to run them from the command-line")
	print("")
	print("USAGE: bootstrap <mode|file>")
	print("")
	print("MODES:")
	print("  -b, --build <module|--all>   Update and Build a single module or")
	print("                               all modules in the Modules directory")
	print("  -i, --install                Update and Build Bootstrap")
	print("")
	print("Note: Use `#!/usr/bin/env bootstrap` to bootstrap your .swift file")
}
