
public struct Board: Codable, Equatable, Hashable {

	public let name: String
	public let tables: [Table]
}

extension Board {

	public static var service: Board { return Board(name: "Service", tables: [.backlog, .archive]) }
}
