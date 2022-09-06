import Foundation

public protocol Store: AnyObject {
    func data(forKey aKey: String) -> Data?
    func set<T>(_ value: T?, for key: String)
    func removeValue(for key: String)
}

extension UserDefaults: Store {
    public func removeValue(for key: String) {
        self.removeObject(forKey: key)
    }
    
    public func set<T>(_ value: T?, for key: String) {
        self.set(value, forKey: key)
    }
}
