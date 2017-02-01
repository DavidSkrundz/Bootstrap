//
//  Package.swift
//  Bootstrap
//

import PackageDescription

let package = Package(
	name: "Bootstrap",
	targets: [
		Target(name: "Bootstrap", dependencies: []),
		Target(name: "Build", dependencies: []),
	],
	dependencies: [
		.Package(url: "https://github.com/DavidSkrundz/CommandLine.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/DavidSkrundz/LibC.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/DavidSkrundz/UnicodeOperators.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/DavidSkrundz/Util.git", majorVersion: 1, minor: 0),
	]
)
