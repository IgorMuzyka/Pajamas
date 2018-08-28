
import FileKit
import RestorablePersistable

public struct Issue: Codable {

	public var index: UInt
	public var description: String

	public var tags: [Tag]
	public var asignee: Contributor?

	public init(description: String) {
		self.index = Issue.newIndex()
		self.description = description
		self.tags = []
	}
}

extension Issue {

	public static var path: Path { return Project.path + "issues" }
}

extension Issue: RestorablePersistable {

	public static var fileExtension: String { return ".issue" }
	public var fileName: String { return "\(index)" }
}

extension Issue: Comparable {

	public static func < (lhs: Issue, rhs: Issue) -> Bool {
		return lhs.index < rhs.index
	}

	public static func == (lhs: Issue, rhs: Issue) -> Bool {
		return lhs.index == rhs.index
	}
}

extension Issue {

	public static func issues() throws -> [Issue] {
		return try Issue.path.children()
			.map(File<Issue>.init)
			.map { try $0.restore() }
			.sorted(by: >)
	}

	public static var count: UInt {
		return (Issue.path.fileReferenceCount ?? 2) - 2
	}

	public static func newIndex() -> UInt {
		return count + 1
	}

}
