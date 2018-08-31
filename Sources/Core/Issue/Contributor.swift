
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

extension Contributor: Saveable {

	public static var path: Path { return Project.path + "contributors" }
}

extension Contributor {

	public static var current: Contributor {
		return Contributor(
			name: run(bash: "git config user.name").stdout,
			email: run(bash: "git config user.email").stdout
		)
	}
}

extension Contributor {

	public static func find(by nameOrEmail: String) throws -> Contributor? {
		guard let contributorPath = path.children().first(where: { $0.fileName.contains(nameOrEmail) }) else {
			return nil
		}
		return try Contributor.restore(from: contributorPath)
	}
}
