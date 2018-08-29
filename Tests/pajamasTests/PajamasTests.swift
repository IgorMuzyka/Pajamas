import XCTest
import Quick
import Nimble
import SwiftShell
import FileKit

class PajamasTests: QuickSpec {

	override func spec() {
		let path = SwiftShell.main.currentdirectory
		let binary = path + ((path.contains("DerivedData")) ? "/PajamasCLI" : "/pajamas")

		func cleanup() {
			SwiftShell.run(bash: "rm -rf \(path)/.pajamas")
			SwiftShell.run(bash: "rm -rf ./.pajamas")
		}

		describe("Main Spec") {
			beforeSuite {
				cleanup()
			}

			afterSuite {
				cleanup()
			}

			context("If Project was not previously created") {
				it("should initialize successfully") {
					expect(SwiftShell.run(bash: "\(binary) init Pajamas").stdout)
						.to(equal("Good luck with your new project: Pajamas"))
				}
			}

			context("If Project was already initalized") {
				it("should fail initialization") {
					expect(SwiftShell.run(bash: "\(binary) init Pajamas").stdout)
						.to(equal("Project Already Initialized"))
				}

				it("should be created on disk") {
					let pajamasPath = Path(path) + ".pajamas"

					expect(pajamasPath.isDirectory).to(equal(true))
					expect(pajamasPath.exists).to(equal(true))
				}
			}

			context("Issue creation") {
				let index = 1
				let description = "Test Issue"

				it("should be created") {
					expect(SwiftShell.run(bash: "\(binary) issue create \"\(description)\"").stdout)
						.to(equal("Created issue \(index): \(description)"))
				}

				it("should be created on disk") {
					expect(Path(path + ".pajamas/issues/1.issue").exists).to(equal(true))
				}
			}

			context("Adding a Contributor") {
				it("contributor should be created") {
					expect(SwiftShell.run(bash: "\(binary) contributor add --name Lol --email lol@kek.cheburek").stdout)
						.to(equal("Added contributor: Contributor(name: \"Lol\", email: \"lol@kek.cheburek\")"))
				}

				it("should be created on disk") {
					expect(Path(path + ".pajamas/contributors/lol@kek.cheburek.Lol.contributor").exists).to(equal(true))
				}
			}

		}
	}
}
