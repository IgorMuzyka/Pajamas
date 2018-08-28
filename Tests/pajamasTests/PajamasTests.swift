import XCTest
import SwiftShell
import FileKit
import Quick
import Nimble

class PajamasTests: QuickSpec {

	override func spec() {
		let path = SwiftShell.main.currentdirectory
		let binary = path + "/pajamas"

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
		}
	}
}
