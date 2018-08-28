
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

	public static var archive: Table { return "Archive" }
	public static var backlog: Table { return "Backlog" }
}
