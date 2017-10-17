//
//  Usage.swift
//  Bootstrap
//

internal func usage() {
	print("OVERVIEW: Update and Build all modules in the Modules directory")
	print("")
	print("USAGE: build <flags> <command>")
	print("")
	print("FLAGS:")
	print("  -u, --update   Fetches the latest commit from origin/master")
	print("                 before building the module")
	print("")
	print("COMMANDS:")
	print("  <module>   Update and Build a single module")
	print("  --all      Update and Build all modules")
}
