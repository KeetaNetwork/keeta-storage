import Foundation
import KeychainSwift

public final class SecureStorage {
    
    public enum Error: Swift.Error, Equatable {
        case noDataForKey(key: String)
        case storageError
    }
    
    let keychain: Keychain
    let access: Accessability
    let encoder: Encoder
    let decoder: Decoder

    public init(
        keychain: Keychain = KeychainSwift(),
        access: Accessability = .accessibleWhenUnlocked,
        encoder: Encoder = JSONEncoder(),
        decoder: Decoder = JSONDecoder()
    ) {
        self.keychain = keychain
        self.access = access
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func object<T: Decodable>(for key: String) throws -> T {
        guard let data = keychain.getData(key), !data.isEmpty else {
            throw Error.noDataForKey(key: key)
        }
        return try decoder.decode(T.self, from: data)
    }
    
    public func store<T: Encodable>(_ object: T, for key: String, with overrideAccess: Accessability? = nil) throws {
        let data = try encoder.encode(object)
        
        if !keychain.set(data, forKey: key, with: overrideAccess ?? self.access) {
            throw Error.storageError
        }
    }
    
    public func removeValue(for key: String) {
        keychain.delete(key)
    }
}
