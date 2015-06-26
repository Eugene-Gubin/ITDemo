//
//  KNUserManager.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

class KNUserManager {
    let kName = "knUserProfile.name"
    let kEmail = "knUserProfile.email"
    let kPwd = "knPassword"
    let kPhone = "knPhone"
    
    let kMinLength = 6
    
    static let sharedInstance = KNUserManager()
    
    func loadUserProfile() -> KNUserProfile? {
        
        let keychain = Keychain()
        
        if  let name = keychain.query(kName),
            let email = keychain.query(kEmail),
            let password = keychain.query(kPwd),
            let phone = keychain.query(kPhone) {
            
                var profile = KNUserProfile()
                profile.name = NSString(data: name, encoding: NSUTF8StringEncoding) as! String
                profile.email = NSString(data: email, encoding: NSUTF8StringEncoding) as! String
                profile.password = NSString(data: password, encoding: NSUTF8StringEncoding) as! String
                profile.phone = NSString(data: phone, encoding: NSUTF8StringEncoding) as! String
                
                return profile
        }
        
        return nil
    }
    
    func saveUserProfile(#name: String, email: String, password: String, phone: String = "") -> KNUserProfileStatus {
        let profile = KNUserProfile(name: name, email: email, password: password, phone: phone)
        return saveUserProfile(profile)
    }
    
    func saveUserPhoneNumber(phone: String) -> KNUserProfileStatus {
        if var up = loadUserProfile() {
            up.phone = phone
            return saveUserProfile(up)
        }
        return .LoadingError
    }
    
    func saveUserProfile(profile: KNUserProfile) -> KNUserProfileStatus {
       
        let status = validateUserProfile(profile)
        if (status != .OK) {
            return status
        }
        
        if  let name = profile.name.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false),
            let email = profile.email.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false),
            let password = profile.email.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false),
            let phone = profile.email.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                
                let keychain = Keychain()
                keychain.update(kName, data: name)
                keychain.update(kPwd, data: password)
                keychain.update(kEmail, data: email)
                keychain.update(kPhone, data: phone)
                
                return .OK
        }
        
        return .SavingError
    }
    
    func validateUserProfile(profile: KNUserProfile) -> KNUserProfileStatus {
        if (count(profile.name) < kMinLength) {
            return .UserNameIsTooShort
        }
        if (count(profile.password) < kMinLength) {
            return .PasswordIsTooShort
        }
        if (!KNEmailValidator.isValid(profile.email)) {
            return .InvalidEmail
        }
        if (!(profile.phone.isEmpty || KNPhoneUtils.sharedInstance.isValid(profile.phone))) {
            return .InvalidPhone
        }
        
        return .OK
    }
}