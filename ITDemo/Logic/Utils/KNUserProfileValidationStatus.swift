//
//  KNUserProfileValidationStatus.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

enum KNUserProfileStatus {
    case OK, UserNameIsTooShort, PasswordIsTooShort, InvalidEmail, SavingError, LoadingError, InvalidPhone
}