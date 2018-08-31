import XCTest
import Quick
import Nimble
import SwiftShell
import FileKit

@testable import PajamasCore

class PajamasTests: QuickSpec {

	private var path: String {
		return SwiftShell.main.currentdirectory
	}

	override func spec() {
		let binary = path + ((path.contains("DerivedData")) ? "/PajamasCLI" : "/pajamas")
		let temp = Path("/tmp/pajamas.test/")


		func setup() {
			if temp.exists {
				try! temp.deleteFile()
			}

			try! temp.createDirectory()

			print(temp.description)

			SwiftShell.main.currentdirectory = temp.description
		}

		func cleanup() {
			try! temp.deleteFile()
		}

		print(path)
		print(Issue.path.children().map { $0.fileName }.joined(separator: ","))

		describe("CLI Spec") {
			beforeSuite {
				setup()
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
					let pajamasPath = Path(self.path) + ".pajamas"

					expect(pajamasPath.isDirectory).to(equal(true))
					expect(pajamasPath.exists).to(equal(true))
				}
			}

			context("Issue creation") {
				let index = 1
				let description = "Test Issue"

				it("should be created") {
					expect(SwiftShell.run(bash: "\(binary) issue create \"\(description)\"").stdout)
						.to(equal("Created issue \(index): \(description) Table(name: \"Backlog\")"))
				}

				it("should be created on disk") {
					expect(Path(self.path + ".pajamas/issues/1.issue").exists).to(equal(true))
				}
			}

			context("Adding a Contributor") {
				it("contributor should be created") {
					expect(SwiftShell.run(bash: "\(binary) contributor add --name Lol --email lol@kek.cheburek").stdout)
						.to(equal("Added contributor: Contributor(name: \"Lol\", email: \"lol@kek.cheburek\")"))
				}

				it("should be created on disk") {
					expect(Path(self.path + ".pajamas/contributors/lol@kek.cheburek.Lol.contributor").exists).to(equal(true))
				}
			}

			context("Assigning Issue") {
				it("issue should be assigned to provided contributor") {
					expect(SwiftShell.run(bash: "\(binary) issue assign 1 --to Lol").stdout)
						.to(equal("Assigned contributor: Contributor(name: \"Lol\", email: \"lol@kek.cheburek\") to issue: 1, Test Issue"))
				}

				it("issue should be assigned to current git user") {
					let contributor = Contributor.current

					expect(SwiftShell.run(bash: "\(binary) issue assign 1").stdout)
						.to(equal("Assigned contributor: Contributor(name: \"\(contributor.name)\", email: \"\(contributor.email)\") to issue: 1, Test Issue"))
				}
			}
		}
	}
}
