
import Files

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

	public static var path: String {
		return Folder.current.path + ".pajamas"
	}
}

extension Project {

	public static func current() throws -> Project {
        return try restore(from: path + "/" + "project" + Project.fileExtension)
	}
}

extension Project {

	public enum InitializationError: Swift.Error {
		case projectAlreadyInitialized
	}

	public func initialize() throws {
        guard (try? Folder(path: Project.path)) == nil else {
            throw InitializationError.projectAlreadyInitialized
        }

        let pajamas = try Folder.current.createSubfolderIfNeeded(withName: ".pajamas")
        try pajamas.createSubfolderIfNeeded(withName: "issues")
        try pajamas.createSubfolderIfNeeded(withName: "contributors")

        try Contributor.current.save()
        try save()
	}
}
