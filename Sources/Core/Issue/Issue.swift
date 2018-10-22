
import Files
import Foundation

public struct Issue: Codable {

	public var identifier: UInt
	public var description: String

	public private(set) var resolutions: [Resolution]
	public var table: Table
	public var asignee: Contributor?

	public var tags: [Tag]

	public init(identifier: UInt = Issue.newIdentifier(), description: String, table: Table) {
		self.identifier = identifier
		self.description = description
		self.table = table
		self.tags = []
		self.resolutions = []
	}
}

extension Issue {

	public enum Status: String, Codable {

		case pending
		case inProgress
		case closed
	}

	public struct Resolution: Codable {

		public let status: Status
		public let message: String
	}

	public var resolution: Resolution? { return resolutions.last }

	public mutating func resolve(with resolution: Resolution) {
		resolutions.append(resolution)
	}
}

extension Issue: Saveable {

	public static var path: String { return Project.path + "/issues" }
}

extension Issue: RestorablePersistable {

	public static var fileExtension: String { return ".issue" }
	public var fileName: String { return "\(identifier)" }
}

extension Issue: Comparable {

	public static func < (lhs: Issue, rhs: Issue) -> Bool {
		return lhs.identifier < rhs.identifier
	}

	public static func == (lhs: Issue, rhs: Issue) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}

extension Issue {

	public static func find(by identifier: String) throws -> Issue? {
        let file = try Folder(path: path).file(named: identifier + fileExtension)
        return try Issue.restore(from: file)
	}

	public static func issues() throws -> [Issue] {
        return try Folder(path: path)
            .makeFileSequence()
            .map(Issue.restore)
	}

	public static var count: UInt {
        return UInt(Folder.current.makeFileSequence().count)
	}

	public static func newIdentifier() -> UInt {
		return count + 1
	}

}
