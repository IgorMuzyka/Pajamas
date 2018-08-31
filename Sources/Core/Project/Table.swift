
import Foundation

public struct Table: Codable, Equatable, Hashable {

	public let name: String

	public init(name: String) {
		self.name = name
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		name = try container.decode(String.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(name)
	}
}

extension Table: ExpressibleByStringLiteral {

	public init(stringLiteral value: StringLiteralType) {
		self.init(name: value)
	}
}

extension Table {

	public static var backlog: Table { return "Backlog" }
	public static var todo: Table { return "Todo" }
	public static var inProgress: Table { return "In Progress" }
	public static var toTest: Table { return "To Test" }
	public static var done: Table { return "Done" }
	public static var archive: Table { return "Archive" }
}
