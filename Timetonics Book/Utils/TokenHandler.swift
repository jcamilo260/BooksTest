//
//  TokenHandler.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation
import Security

class TokenHandler{
    
    /// Saves a token
    /// - Parameters:
    ///   - serviceName: Name of the token
    ///   - token: element that you want to encode
    public static func saveToken(serviceName: String, token: String){
        if let data = token.data(using: .utf8){
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: serviceName,
                kSecValueData as String: data
            ]
            
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Token could not be saved: \(status)")
                return
            }
        }
        
    }
    
    /// Get an specific token
    /// - Parameter serviceName: Name of the token
    /// - Returns: returns the decoded token
    static func getToken(serviceName: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            print("We could not get the token: \(status)")
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    /// Delete an specific token
    /// - Parameter serviceName: token that you want to delete
    static func deleteToken(serviceName: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            print("We could not delete the token: \(status)")
            return
        }
    }
    
    /// Shows in console all the keys
    static func printAllKeys() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnAttributes as String: kCFBooleanTrue!
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let items = result as? [[String: Any]] else {
            print("Error showing all the keys: \(status)")
            return
        }
        
        print("Here are all the keys:")
        for item in items {
            if let serviceName = item[kSecAttrService as String] as? String,
               let account = item[kSecAttrAccount as String] as? String {
                print("Service name: \(serviceName), account: \(account)")
            }
        }
    }
    
}
