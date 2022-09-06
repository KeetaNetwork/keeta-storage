import Foundation

public protocol Encoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

public protocol Decoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: Decoder {}
extension JSONEncoder: Encoder {}
