// swift-tools-version:4.0
//
//  Package.swift
//  Bootstrap
//

import PackageDescription

let package = Package(
	name: "Bootstrap",
	dependencies: [
		.package(url: "https://github.com/DavidSkrundz/Collections.git",
		         .upToNextMinor(from: "1.0.0")),
		.package(url: "https://github.com/DavidSkrundz/CommandLine.git",
		         .upToNextMinor(from: "1.3.0")),
		.package(url: "https://github.com/DavidSkrundz/LibC.git",
		         .upToNextMinor(from: "1.1.0"))
	],
	targets: [
		.target(
			name: "Bootstrap",
			dependencies: ["CommandLine", "LibC"]),
		.target(
			name: "Build",
			dependencies: ["CommandLine", "LibC"])
	]
)
