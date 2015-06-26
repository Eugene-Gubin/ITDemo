//
//  KNMapViewController.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class KNMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var vwMap: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .AuthorizedWhenInUse:
            vwMap.setUserTrackingMode(.Follow, animated: true)
            break
        default:
            break
        }
    }
    
    @objc func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedWhenInUse) {
            vwMap.setUserTrackingMode(.Follow, animated: true)
        }
    }
    
    @objc func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let ul = annotation as? MKUserLocation {
            if let profile = KNUserManager.sharedInstance.loadUserProfile() {
                ul.title = profile.name
            }
        }
        return nil
    }
}
