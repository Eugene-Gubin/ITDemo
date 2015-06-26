//
//  KNUserProfileStatusExtensions.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

extension KNUserProfileStatus {
    // todo: localize
    var errorMessage: String {
        switch self {
        case .OK: return "OK"
        case .InvalidEmail: return "Email is invalid"
        case .PasswordIsTooShort: return "Password must contain 6 or more characters"
        case .UserNameIsTooShort: return "User name must contain 6 or more characters"
        case .SavingError: return "Cann't store user profile"
        }
    }
}