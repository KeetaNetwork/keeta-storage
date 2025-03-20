# Keeta Secure Storage

Leightweight `Storage` absrtraction for agnostic persistence implementations.

```swift
public protocol Store: AnyObject {
    func data(forKey aKey: String) -> Data?
    func set(_ data: Data, for key: String)
    func removeValue(for key: String)
}
```

Includes two default implementations:

- [Keychain](https://github.com/evgenyneu/keychain-swift)
- [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)
