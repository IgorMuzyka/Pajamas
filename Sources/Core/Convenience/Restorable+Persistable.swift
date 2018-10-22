
import Foundation
import Files

private struct Codec {

    fileprivate static let decoder = JSONDecoder()
    fileprivate static let encoder = JSONEncoder()
}

public typealias RestorablePersistable = Restorable & Persistable

public protocol Restorable: Decodable {}

public protocol Persistable: Encodable {

    static var fileExtension: String { get }
    var fileName: String { get }
}

extension Restorable {

    public static func restore(from file: File) throws -> Self {
        let data = try file.read()
        return try Codec.decoder.decode(Self.self, from: data)
    }

    public static func restore(from path: String) throws -> Self {
        return try restore(from: File(path: path))
    }
}

extension Persistable {

    @discardableResult
    public func persist(to folder: Folder) throws -> File {
        let file = try folder.createFile(named: fileName + Self.fileExtension)
        let data = try Codec.encoder.encode(self)
        try file.write(data: data)
        return file
    }

    @discardableResult
    public func persist(to path: String) throws -> File {
        return try persist(to: Folder(path: path))
    }
}
