import XCTest
import Quick
import Nimble
import SwiftShell
import Files

@testable import PajamasCore

class PajamasTests: QuickSpec {

	private var path: String {
		return SwiftShell.main.currentdirectory
	}

	override func spec() {
		let binary = path + ((path.contains("DerivedData")) ? "/PajamasCLI" : "/pajamas")
		let temp = try! Folder.temporary.createSubfolderIfNeeded(withName: "pajamas.test")

		func setup() {
            cleanup()

            try! Folder.temporary.createSubfolderIfNeeded(withName: "pajamas.test")

			SwiftShell.main.currentdirectory = temp.path
		}

		func cleanup() {
            if Folder.temporary.containsSubfolder(named: "pajamas.test") {
                try! temp.delete()
            }
		}

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
                    let folder = try! Folder(path: self.path)
                    expect(folder.containsSubfolder(named: ".pajamas")).to(equal(true))
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
                    let folder = try! Folder(path: self.path + ".pajamas/issues")

                    expect(folder.containsFile(named: "1.issue")).to(equal(true))
                }
            }

            context("Adding a Contributor") {
                it("contributor should be created") {
                    expect(SwiftShell.run(bash: "\(binary) contributor add --name Lol --email lol@kek.cheburek").stdout)
                        .to(equal("Added contributor: Contributor(name: \"Lol\", email: \"lol@kek.cheburek\")"))
                }

                it("should be created on disk") {
                    let folder = try! Folder(path: self.path + "/.pajamas/contributors")

                    expect(folder.containsFile(named: "lol@kek.cheburek.Lol.contributor")).to(equal(true))
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
