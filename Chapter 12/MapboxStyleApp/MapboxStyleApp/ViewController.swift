//
//  ViewController.swift
//  MapboxStyleApp
//
//  Created by Jeffrey Linwood on 4/22/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController {
    
    let mapStyleURI = "mapbox://styles/your_username/style_id"

    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.centerCoordinate = CLLocationCoordinate2D(
                   latitude: 30.2,
                   longitude: -97.75)
               mapView.zoomLevel = 10
        mapView.styleURL = URL(string: mapStyleURI)
    }


}

