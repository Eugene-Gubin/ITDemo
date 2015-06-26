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
        toggleSideMenu()
        
        let home = UIStoryboard(name: KNDefinitions.kStoryboardHome, bundle: nil)
        let feedVC = home.instantiateViewControllerWithIdentifier(KNDefinitions.kKNNYTFeedViewController) as! UIViewController
        setChildViewController(feedVC)
    }
    
    @IBAction func handleToggleMenu(sender: AnyObject) {
        toggleSideMenu()
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
        vc.view.frame = vwContainer.bounds
        vwContainer.addSubview(vc.view)
        vc.didMoveToParentViewController(self)
    }
    
    func swapToChildViewController(vc: UIViewController) {
        let fromViewController = childViewControllers.first as! UIViewController
        fromViewController.willMoveToParentViewController(nil)
        
        addChildViewController(vc)
        vc.view.frame = vwContainer.bounds
        
        transitionFromViewController(fromViewController, toViewController: vc, duration: 0.3, options: .TransitionCrossDissolve, animations: nil) { _ in
            fromViewController.removeFromParentViewController()
            vc.didMoveToParentViewController(self)
        }
    }
}