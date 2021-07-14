//
//  ViewController.swift
//  FirstMapsApp
//
//  Created by Jeffrey Linwood.
//  Copyright © 2019 Jeff Linwood. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let austin = MKPointAnnotation()
        austin.coordinate = CLLocationCoordinate2DMake(30.25, -97.75)
        austin.title = "Austin"
        mapView.addAnnotation(austin)
        
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_
        manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
           case .authorizedWhenInUse:
               print("Authorized When in Use")
           case .authorizedAlways:
               print("Authorized Always")
           case .denied:
               print("Denied")
           case .notDetermined:
               print("Not determined")
           case .restricted:
               print("Restricted")
           @unknown default:
               print("Unknown status")
        }
    }
}

