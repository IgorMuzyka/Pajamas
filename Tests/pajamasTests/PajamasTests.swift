import XCTest
import Quick
import Nimble
import SwiftShell
import FileKit

class PajamasTests: QuickSpec {

	override func spec() {
		let path = SwiftShell.main.currentdirectory
		let binary = path + "/pajamas"

		func cleanup() {
			SwiftShell.run(bash: "rm -rf \(path)/.pajamas")
			SwiftShell.run(bash: "rm -rf ./.pajamas")
		}

		print(SwiftShell.run(bash: "echo \(path)").stdout)

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

				

//				it("should be created on disk") {
//					let project = try? Pajamas.Project.restore(from: Path(path + "/.pajamas/.project.pj"))
//					let project = try? File<Project>(path: ).restore()

//					expect(project?.name).to(equal("Pajamas"))
//				}
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
