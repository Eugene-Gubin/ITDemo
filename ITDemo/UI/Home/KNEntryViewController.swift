//
//  KNEntryViewController.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit

class KNEntryViewController: UIViewController {
    
    @IBOutlet weak var vwWeb: UIWebView!
    
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: link) {
            let request = NSURLRequest(URL: url)
            vwWeb.loadRequest(request)
        }
    }
}