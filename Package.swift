// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pajamas",
	products: [
		.executable(name: "pajamas", targets: ["PajamasCLI"]),
		.library(name: "pajamas-core", targets: ["PajamasCore"])
	],
    dependencies: [
		.package(url: "https://github.com/kareman/SwiftShell", from: "4.0.0"),
		.package(url: "https://github.com/nvzqz/FileKit", from: "5.1.0"),
		.package(url: "https://github.com/IgorMuzyka/FileKit-RestorablePersistable", .branch("master")),

		.package(url: "https://github.com/IgorMuzyka/Cncurses", .branch("master")),
		.package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
		.package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),

		.package(url: "https://github.com/Quick/Quick", from: "1.3.0"),
		.package(url: "https://github.com/Quick/Nimble", from: "7.1.0"),
    ],
    targets: [
		.target(
			name: "PajamasCore",
			dependencies: [
				"FileKit",
				"RestorablePersistable",
			],
			path: "Sources/Core"
		),
        .target(
            name: "PajamasCLI",
            dependencies: [
				"PajamasCore",
				"Commander",
				"Rainbow",
				"SwiftShell",
				"Cncurses",
			],
			path: "Sources/CLI"
		),
        .testTarget(
            name: "PajamasTests",
            dependencies: [
				"PajamasCLI",
				"Quick",
				"Nimble",
				"SwiftShell",
				"FileKit",
			]
		),
    ]
)
