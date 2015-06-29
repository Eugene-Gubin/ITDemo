//
//  Keychain.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation
import Security

class KNKeychain {
    
    private let kSecurityClass = kSecClass as String
    private let kAccount = kSecAttrAccount as String
    private let kValueData = kSecValueData as String
    private let kReturnData = kSecReturnData as String
    private let kMatchLimit = kSecMatchLimit as String
    
    private let kGenericPwd = kSecClassGenericPassword as String
    private let kOnlyFirst = kSecMatchLimitOne as String
    
    func update(key: String, data: NSData) -> Bool {
        let query = [
            kSecurityClass : kGenericPwd,
            kAccount : key,
            kValueData : data]
        
        SecItemDelete(query as CFDictionaryRef)
        
        let status = SecItemAdd(query as CFDictionaryRef, nil)
        
        return status == noErr
    }
    
    func query(key: String) -> NSData? {
        let query = [
            kSecurityClass : kGenericPwd,
            kAccount : key,
            kReturnData : kCFBooleanTrue,
            kMatchLimit : kOnlyFirst]
        
        var result: Unmanaged<AnyObject>?
        
        let status = SecItemCopyMatching(query, &result)
        
        if status == noErr {
            return (result!.takeRetainedValue() as! NSData)
        }
        
        return nil
    }
    
    func delete(key: String) -> Bool {
        let query = [
            kSecurityClass : kGenericPwd,
            kAccount : key]
        
        let status = SecItemDelete(query as CFDictionaryRef)
        
        return status == noErr
    }
    
    
    func clear() -> Bool {
        let query = [kSecurityClass : kGenericPwd]
        
        let status = SecItemDelete(query as CFDictionaryRef)
        
        return status == noErr
    }
    
}