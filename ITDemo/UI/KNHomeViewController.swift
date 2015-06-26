//
//  KNHomeViewController.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit

class KNHomeViewController: UIViewController {

    private let kMenuWidth = 200
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lcMenuLeftMargin: NSLayoutConstraint!
    
    private var sideMenuIsPresented = false
    
    @IBAction func handlePhotoEditorTapped(sender: AnyObject) {
        
    }
    
    @IBAction func handleMapTapped(sender: AnyObject) {
        
    }
    
    @IBAction func handleRSSTapped(sender: AnyObject) {
        
    }
    
    @IBAction func handleToggleMenu(sender: AnyObject) {
        toggleSideMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func toggleSideMenu() {
        sideMenuIsPresented = !sideMenuIsPresented
        let leftMargin = sideMenuIsPresented ? 0 : -kMenuWidth
        self.lcMenuLeftMargin.constant = CGFloat(leftMargin)
        UIView.animateWithDuration(0.5) { () -> () in
            self.view.layoutIfNeeded()
        }
    }
}
