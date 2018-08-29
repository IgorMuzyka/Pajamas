
import FileKit
import RestorablePersistable

public struct Project: Codable, Equatable, Hashable {

	public let name: String
	public let boards: [Board]
}

extension Project {

	public static func `default`(name: String) -> Project {
		return Project(name: name, boards: [
			.service,
			Board(name: "Default", tables: [
				"Todo",
				"In Progress",
				"To Test",
				"Done"
			])
		])
	}
}

extension Project: RestorablePersistable {

	public static var fileExtension: String = ".pj"
	public var fileName: String { return "project" }
}

extension Project {

	public static var path: Path {
		return .current + ".pajamas"
	}

	public static func current() throws -> Project {
		return try restore(from: path)
	}
}

extension Project {

	public enum InitializationError: Swift.Error {
		case projectAlreadyInitialized
	}

	public func initialize() throws {
		guard !Project.path.exists else { throw InitializationError.projectAlreadyInitialized }

		try Project.path.createDirectory()
		try Issue.path.createDirectory()
		try Contributor.path.createDirectory()
		try persist(to: Project.path)
	}
}
