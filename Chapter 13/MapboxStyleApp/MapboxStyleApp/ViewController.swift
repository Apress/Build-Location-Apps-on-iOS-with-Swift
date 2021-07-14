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
                   latitude: 61.2,
                   longitude: -149.9)
        mapView.zoomLevel = 3
        mapView.styleURL = URL(string: mapStyleURI)
        addGestureRecognizer()
    }
    
    func addGestureRecognizer() {
        let tapGR = UITapGestureRecognizer(target: self,
            action: #selector(mapTapped(sender:)))
        // The mapview has its own gesture recognizers for responding to user actions
        // Only use the new gesture recognizer if those don't match
        for recognizer in mapView.gestureRecognizers!
            where recognizer is UITapGestureRecognizer {
            tapGR.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(tapGR)
    }
    
    @objc func mapTapped(sender: UITapGestureRecognizer) {
        let mapPoint = sender.location(in: mapView)
        
        let features = mapView.visibleFeatures(at: mapPoint)
        print(features)
    }
}

