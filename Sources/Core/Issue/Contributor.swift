
import SwiftShell
import FileKit
import RestorablePersistable

public struct Contributor: Codable {

	public var name: String
	public var email: String

	public init(name: String, email: String) {
		self.name = name
		self.email = email
	}
}

extension Contributor: RestorablePersistable {

	public static var fileExtension: String { return ".contributor" }
	public var fileName: String { return email + "." + name }
}

extension Contributor {

	public static var path: Path { return Project.path + "contributors" }
}

extension Contributor {

	public var current: Contributor {
		return Contributor(
			name: run(bash: "git config user.name").stdout,
			email: run(bash: "git config user.email").stdout
		)
	}
}
