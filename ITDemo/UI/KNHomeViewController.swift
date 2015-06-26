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
        toggleSideMenu()
        
        let home = UIStoryboard(name: KNDefinitions.kStoryboardHome, bundle: nil)
        let mapVC = home.instantiateViewControllerWithIdentifier(KNDefinitions.kKNMapViewController) as! UIViewController
        setChildViewController(mapVC)
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
        UIView.animateWithDuration(0.2) { () -> () in
            self.view.layoutIfNeeded()
        }
    }
    
    func setChildViewController(vc: UIViewController) {
        if childViewControllers.isEmpty {
            setInitialChildViewController(vc)
        } else {
            swapToChildViewController(vc)
        }
    }
    
    func setInitialChildViewController(vc: UIViewController) {
        addChildViewController(vc)
        vc.view.frame = self.view.bounds
        vwContainer.addSubview(vc.view)
        vc.didMoveToParentViewController(self)
    }
    
    func swapToChildViewController(vc: UIViewController) {
        vc.view.frame = self.view.bounds
        let fromViewController = childViewControllers.first as! UIViewController
        fromViewController.willMoveToParentViewController(nil)
        
        transitionFromViewController(fromViewController, toViewController: vc, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: nil) { _ in
            fromViewController.removeFromParentViewController()
            vc.didMoveToParentViewController(self)
        }
    }
}