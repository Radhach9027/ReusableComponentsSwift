import SwiftKeychainWrapper
import Foundation

public struct Keychain<T> where T: Codable {
    
    public static func storeData(value: T, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            KeychainWrapper.standard.set(data, forKey: key)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public static func retriveData(key: String) -> T? {
        if let value = KeychainWrapper.standard.data(forKey: key) {
            return value as? T
        }
        return nil
    }
    
    @discardableResult
    public static func clearData(key: String) -> Bool {
        let status = KeychainWrapper.standard.removeObject(forKey: key)
        return status
    }
}


