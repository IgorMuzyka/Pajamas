
import FileKit
import RestorablePersistable

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

	public static var path: Path { return Project.path + "issues" }
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
		guard let issuePath = path.children().first(where: { $0.fileName == (identifier + Issue.fileExtension) }) else {
			return nil
		}
		return try Issue.restore(from: issuePath)
	}

	public static func issues() throws -> [Issue] {
		return try Issue.path.children()
			.map(File<Issue>.init)
			.map { try $0.restore() }
			.sorted(by: >)
	}

	public static var count: UInt {
		return (Issue.path.fileReferenceCount ?? 2) - 2
	}

	public static func newIdentifier() -> UInt {
		return count + 1
	}

}
