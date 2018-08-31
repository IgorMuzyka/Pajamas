
import FileKit
import RestorablePersistable

public struct Project: Codable, Equatable, Hashable {

	public let name: String
	public let board: Board
}

extension Project {

	public static func `default`(name: String) -> Project {
		return Project(name: name, board: .default)
	}
}

extension Project: RestorablePersistable {

	public static var fileExtension: String = ".pj"
	public var fileName: String { return "project" }
}

extension Project: Saveable {

	public static var path: Path {
		return .current + ".pajamas"
	}
}

extension Project {

	public static func current() throws -> Project {
		return try restore(from: path + "project\(Project.fileExtension)") 
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
		try Contributor.current.save()
		try save()
	}
}
