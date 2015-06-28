//
//  KNRegistrationViewController.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit

class KNRegistrationViewController: UIViewController {

    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!

    @IBAction func handleRegisterTapped(sender: AnyObject) {
        let um = KNUserManager.sharedInstance
        let status = um.saveUserProfile(name: lblUserName.text, email: lblEmail.text, password: lblPassword.text)
        if (status == .OK) {
            performSegueWithIdentifier(KNDefinitions.kSeguePhoneScreen, sender: self)
        } else {
            UIAlertView(title: nil, message: status.errorMessage, delegate: nil, cancelButtonTitle: "common.ok".localized).show()
        }
    }
    
    @IBAction func handleTextFieldIsFilled(sender: AnyObject) {
        if (sender === lblUserName) {
            lblEmail.becomeFirstResponder()
        }
        if (sender === lblEmail) {
            lblPassword.becomeFirstResponder()
        }
    }
}
