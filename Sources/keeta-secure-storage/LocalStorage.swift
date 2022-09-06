import Foundation

public final class LocalStorage {
    
    public enum Error: Swift.Error, Equatable {
        case noDataForKey(key: String)
    }
    
    let store: Store
    let encoder: Encoder
    let decoder: Decoder

    public init(store: Store, encoder: Encoder = JSONEncoder(), decoder: Decoder = JSONDecoder()) {
        self.store = store
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func optionalValue<T: Decodable>(forKey key: String) -> Optional<T> {
        guard let data = store.data(forKey: key) else {
            return nil
        }
        return try? decoder.decode(T.self, from: data)
    }
    
    public func value<T: Decodable>(forKey key: String) throws -> T {
        guard let data = store.data(forKey: key), !data.isEmpty else {
            throw Error.noDataForKey(key: key)
        }
        return try decoder.decode(T.self, from: data)
    }
    
    public func set<T: Encodable>(_ value: T?, forKey key: String) throws {
        if let value = value {
            store.set(try encoder.encode(value), for: key)
        } else {
            store.removeValue(for: key)
        }
    }
    
    public func removeValue(for key: String) {
        store.removeValue(for: key)
    }
}
