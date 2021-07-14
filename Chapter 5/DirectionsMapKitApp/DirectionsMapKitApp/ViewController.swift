//
//  ViewController.swift
//  DirectionsMapKitApp
//
//  Created by Jeffrey Linwood on 12/7/19.
//  Copyright © 2019 Jeff Linwood. All rights reserved.
//

import UIKit

import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    
    var currentRoute:MKRoute?
    var currentStepIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        getDirections()
    }
    
    func getDirections() {
        let request = MKDirections.Request()
        // New York City
        request.source = createMapItem(latitude: 40.7128, longitude: -74)
        // Washington, DC
        request.destination = createMapItem(latitude: 38.91, longitude: -77.037)
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let response = response else {
                print(error ?? "No error found")
                return
            }
            let route = response.routes[0]
            self.currentRoute = route
            self.displayCurrentStep()
            let padding = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
            self.mapView.addOverlay(route.polyline)
        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                           edgePadding: padding,
                                           animated: true)
        }
    }
    
    func displayRouteSteps(_ route:MKRoute) {
        for step in route.steps {
            print("Go \(step.distance) meters")
            print(step.instructions)
        }
    }
    
    func createMapItem(latitude:Double, longitude:Double) -> MKMapItem {
        let coord = CLLocationCoordinate2D(latitude: latitude,
                               longitude: longitude)
        let placemark = MKPlacemark(coordinate: coord)
        return MKMapItem(placemark: placemark)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        return renderer
    }
    
    @IBAction func previous(_ sender: Any) {
        if currentRoute == nil {
            return
        }
        
        if (currentStepIndex <= 0) {
            return
        }
        currentStepIndex -= 1
        displayCurrentStep()
    }
    
    @IBAction func next(_ sender: Any) {
        guard let currentRoute = currentRoute else {
            return
        }
        if (currentStepIndex >= (currentRoute.steps.count - 1)) {
            return
        }
        currentStepIndex += 1
        displayCurrentStep()
    }
    
    func displayCurrentStep() {
        guard let currentRoute = currentRoute else {
            return
        }
        if (currentStepIndex >= currentRoute.steps.count) {
            return
        }
        let step = currentRoute.steps[currentStepIndex]
        instructionsLabel.text = step.instructions
        distanceLabel.text = "\(step.distance) meters"
        if step.notice != nil {
            noticeLabel.isHidden = false
            noticeLabel.text = step.notice
        } else {
            noticeLabel.isHidden = true
        }
        previousButton.isEnabled = currentStepIndex > 0
        nextButton.isEnabled = currentStepIndex < (currentRoute.steps.count - 1)
        let padding = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
    mapView.setVisibleMapRect(step.polyline.boundingMapRect,
        edgePadding: padding,
        animated: true)
    }
}

