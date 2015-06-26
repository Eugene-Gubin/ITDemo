//
//  KNPhoneViewController.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit

class KNPhoneViewController: UIViewController {

    @IBOutlet weak var tfPhone: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfPhone.text = KNPhoneUtils.sharedInstance.getUserCountryCode()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    @IBAction func handleContinueTapped(sender: AnyObject) {
        let isValid = KNPhoneUtils.sharedInstance.isValid(tfPhone.text)
    }
}
