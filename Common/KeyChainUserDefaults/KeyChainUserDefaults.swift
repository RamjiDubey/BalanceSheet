//
//  KeyChainUserDefaults.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Foundation

class KeychainUserDefault {

    private let service = "com.ram.code.service.keychain"
    static let shared: KeychainUserDefault = .init()
    
    private init() {}
    
    func set(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func object(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
}

extension KeychainUserDefault {
    @AppKeychainUserDefault(key: "googleLoginInfo")
    static var googleLoginInfo: SocialLoginInfo?
}
