//
//  ViewController.swift
//  GeofencesApp
//
//  Created by Jeffrey Linwood on 12/7/19.
//  Copyright © 2019 Jeff Linwood. All rights reserved.
//

import UIKit

import CoreLocation

class ViewController: UIViewController {
    
    var locationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        monitorGeofences()
        
        //stopMonitoringGeofences()
    }
    
    func monitorGeofences() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let coord = CLLocationCoordinate2D(latitude: 37.5, longitude: -110.2)
            let region = CLCircularRegion(center: coord, radius: 100, identifier: "Geofence1")
            region.notifyOnEntry = true
            region.notifyOnExit = true
            
            locationManager.startMonitoring(for: region)
        }
    }
    
    func stopMonitoringGeofences() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
}

extension ViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit \(region.identifier)")
    }
}

