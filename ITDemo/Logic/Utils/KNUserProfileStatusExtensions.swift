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
        case .OK: return "userProfile.status.ok".localized
        case .InvalidEmail: return "userProfile.status.emailIsInvalid".localized
        case .PasswordIsTooShort: return "userProfile.status.passwordIsTooShort".localized
        case .UserNameIsTooShort: return "userProfile.status.userNameIsTooShort".localized
        case .SavingError: return "userProfile.status.savingError".localized
        }
    }
}