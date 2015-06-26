//
//  KNEmailValidator.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

public struct KNEmailValidator {
    private static let kEmailPattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    static func isValid(email: String) -> Bool {
        let isValidEmail = NSPredicate(format:"SELF MATCHES %@", kEmailPattern)
        return isValidEmail.evaluateWithObject(email)
    }
}