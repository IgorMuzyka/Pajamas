
public protocol Saveable: Persistable {

	static var path: String { get }
}

extension Persistable where Self: Saveable {

	public func save() throws {
        try persist(to: Self.path)
	}
}
