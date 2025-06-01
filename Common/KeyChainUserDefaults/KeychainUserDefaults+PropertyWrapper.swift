//
//  KeychainUserDefaults+PropertyWrapper.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Foundation

@propertyWrapper
struct AppKeychainUserDefault<Value: Codable> {
    
    let key: String
    let defaultValue: Value
    let container: KeychainUserDefault
    
    init(key: String, defaultValue: Value, container: KeychainUserDefault = .shared) {
        self.key = key
        self.container = container
        self.defaultValue = defaultValue
        if let data = container.object(forKey: key) {
            let storedValue = try? JSONDecoder().decode(Value.self, from: data)
            wrappedValue = storedValue ?? defaultValue
        } else {
            wrappedValue = defaultValue
        }
    }
    
    var wrappedValue: Value {
        get {
            if let data = container.object(forKey: key) {
                let storedValue = try? JSONDecoder().decode(Value.self, from: data)
                return storedValue ?? defaultValue
            } else {
                return defaultValue
            }
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                container.set(encodedData, forKey: key)
            }
        }
    }
}

extension AppKeychainUserDefault where Value: ExpressibleByNilLiteral {
    
    init(key: String, _ container: KeychainUserDefault = .shared) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}
