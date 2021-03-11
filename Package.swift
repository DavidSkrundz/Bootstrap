// swift-tools-version:5.0
//
//  Package.swift
//  Bootstrap
//

import PackageDescription

let package = Package(
	name: "Bootstrap",
	dependencies: [
		.package(url: "https://github.com/DavidSkrundz/CommandLine.git",
		         .upToNextMinor(from: "2.0.0")),
		.package(url: "https://github.com/DavidSkrundz/LibC.git",
		         .upToNextMinor(from: "2.0.0"))
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
