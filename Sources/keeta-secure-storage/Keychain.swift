import Foundation
import KeychainSwift

public protocol Keychain {
    func set(_ data: Data, forKey key: String, with access: Accessability) -> Bool
    func getData(_ key: String) -> Data?
    @discardableResult
    func delete(_ key: String) -> Bool
    @discardableResult
    func clear() -> Bool
}

public enum Accessability {
    case accessibleWhenUnlocked
    case accessibleWhenUnlockedThisDeviceOnly
    case accessibleAfterFirstUnlock
    case accessibleAfterFirstUnlockThisDeviceOnly
}

extension KeychainSwift: Keychain {
    public func set(_ data: Data, forKey key: String, with access: Accessability) -> Bool {
        set(data, forKey: key, withAccess: accessOption(for: access))
    }
 
    private func accessOption(for access: Accessability) -> KeychainSwiftAccessOptions {
        switch access {
        case .accessibleWhenUnlocked:
            return .accessibleWhenUnlocked
        case .accessibleWhenUnlockedThisDeviceOnly:
            return .accessibleWhenUnlockedThisDeviceOnly
        case .accessibleAfterFirstUnlock:
            return .accessibleAfterFirstUnlock
        case .accessibleAfterFirstUnlockThisDeviceOnly:
            return .accessibleAfterFirstUnlockThisDeviceOnly
        }
    }
    
    public func getData(_ key: String) -> Data? {
        getData(key, asReference: false)
    }
}
