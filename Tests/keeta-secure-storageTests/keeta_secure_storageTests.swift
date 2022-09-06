import XCTest
@testable import keeta_secure_storage

final class keeta_secure_storageTests: XCTestCase {
    
    let value = "Value"
    let key = "key"
    
    func basic_localStorage_test() throws {
        let sut = LocalStorage(store: UserDefaults(suiteName: UUID().uuidString)!)
        
        try sut.set(value, forKey: key)
        
        let expectedValue: String = try sut.value(forKey: key)
        XCTAssertEqual(expectedValue, value)
        
        sut.removeValue(for: key)
        
        let expectedNil: String? = sut.optionalValue(forKey: key)
        XCTAssertNil(expectedNil)
        
        do {
            let _: String = try sut.value(forKey: key)
            XCTFail()
        } catch let error as LocalStorage.Error {
            XCTAssertEqual(error, .noDataForKey(key: key))
        } catch {
            XCTFail()
        }
    }
}
