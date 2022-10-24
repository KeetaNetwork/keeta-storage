import Foundation

public protocol Store: AnyObject {
    func data(forKey aKey: String) -> Data?
    func set(_ data: Data, for key: String)
    func removeValue(for key: String)
}

extension UserDefaults: Store {
    public func removeValue(for key: String) {
        removeObject(forKey: key)
    }
    
    public func set(_ data: Data, for key: String) {
        set(data, forKey: key)
    }
}
