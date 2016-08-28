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
		.Package(url: "https://github.com/DavidSkrundz/CommandLine.git", versions: Version(1,0,0)..<Version(1,1,0)),
		.Package(url: "https://github.com/DavidSkrundz/LibC.git", versions: Version(1,0,0)..<Version(1,1,0)),
		.Package(url: "https://github.com/DavidSkrundz/UnicodeOperators.git", versions: Version(1,0,0)..<Version(1,1,0)),
		.Package(url: "https://github.com/DavidSkrundz/Util.git", versions: Version(1,0,0)..<Version(1,1,0)),
	]
)
