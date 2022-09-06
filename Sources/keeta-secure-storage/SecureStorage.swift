import Foundation
import KeychainSwift

public final class SecureStorage {
    
    public enum Error: Swift.Error, Equatable {
        case noDataForKey(key: String)
        case storageError
    }
    
    let keychain: Keychain
    let encoder: Encoder
    let decoder: Decoder

    public init(keychain: Keychain = KeychainSwift(), encoder: Encoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.keychain = keychain
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func object<T: Decodable>(for key: String) throws -> T {
        guard let data = keychain.getData(key), !data.isEmpty else {
            throw Error.noDataForKey(key: key)
        }
        return try decoder.decode(T.self, from: data)
    }
    
    public func store<T: Encodable>(_ object: T, for key: String, with access: Accessability) throws {
        let data = try encoder.encode(object)
        
        if !keychain.set(data, forKey: key, with: access) {
            throw Error.storageError
        }
    }
}
