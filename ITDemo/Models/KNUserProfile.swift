//
//  KNUserProfile.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

struct KNUserProfile {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    
    init() {
        // do nothing
    }
    
    init (name: String, email: String, password: String, phone: String) {
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
    }
}