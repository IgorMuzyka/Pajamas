
public struct Board: Codable, Equatable, Hashable {

	public let name: String
	public let tables: [Table]
}

extension Board {

	public static var `default`: Board {
		return Board(
			name: "Default",
			tables: [
				.backlog,
				.todo,
				.inProgress,
				.toTest,
				.done,
				.archive,
			]
		)
	}
}

extension Board {

	public func has(_ table: Table) -> Bool {
		return tables.contains(table)
	}
}
