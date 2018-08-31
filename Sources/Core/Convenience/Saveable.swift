
import FileKit
import RestorablePersistable

public protocol Saveable: Persistable {

	static var path: Path { get }
}

extension Persistable where Self: Saveable {

	public func save() throws {
		try persist(to: Self.path)
	}
}
