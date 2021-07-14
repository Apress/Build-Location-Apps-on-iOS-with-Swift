//
//  ViewController.swift
//  FirstMapboxApp
//
//  Created by Jeffrey Linwood on 4/18/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit

import Mapbox

class ViewController: UIViewController {
    

    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.centerCoordinate = CLLocationCoordinate2D(
            latitude: 30.2,
            longitude: -97.75)
        mapView.zoomLevel = 10
        mapView.styleURL = MGLStyle.outdoorsStyleURL
        
        mapView.delegate = self
        displayAnnotation()
    }

    func displayAnnotation() {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: 30.25,
            longitude: -97.75)
        annotation.title = "Austin"
        annotation.subtitle = "Texas"
        mapView.addAnnotation(annotation)
    }
}

extension ViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView,
                 annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

