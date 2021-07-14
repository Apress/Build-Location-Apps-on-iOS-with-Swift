//
//  ViewController.swift
//  GoogleMapsApp
//
//  Created by Jeffrey Linwood on 1/17/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit

import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(
          withLatitude: 30.25,
          longitude: -97.7,
          zoom: 7)
        mapView.animate(to: camera)
        mapView.mapType = .normal
        mapView.delegate = self
        addMarker()
        addCircle()
        addPolyline()
        addPolygon()
        //mapView.clear()
    }
    
    func addMarker() {
        let marker = GMSMarker()
        marker.title = "Austin"
        marker.snippet = "Texas"
        marker.position = CLLocationCoordinate2D(latitude: 30.25, longitude: -97.75)
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.userData = 1234
    }
    
    func addCircle() {
        let circle = GMSCircle()
        circle.fillColor = UIColor(white: 0.6, alpha: 0.7)
        circle.strokeColor = .darkGray
        circle.radius = 20 * 1000
        circle.position = CLLocationCoordinate2D(latitude: 30.25, longitude: -97.75)
        circle.map = mapView
    }
    
    func addPolyline() {
        let path = GMSMutablePath()
        path.addLatitude(30.25, longitude: -97.75)
        path.addLatitude(29.4, longitude: -98.5)
        path.addLatitude(29.76, longitude: -95.37)
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .red
        polyline.strokeWidth = 3
        polyline.map = mapView
    }
    
    func addPolygon() {
        let path = GMSMutablePath()
        path.addLatitude(30.25, longitude: -97.75)
        path.addLatitude(29.4, longitude: -98.5)
        path.addLatitude(29.76, longitude: -95.37)
        let polygon = GMSPolygon(path: path)
        polygon.strokeColor = .black
        polygon.strokeWidth = 2
        polygon.fillColor = UIColor(
            red: 1, green: 0, blue: 0, alpha: 0.3)
        polygon.map = mapView
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Marker: \(marker.title ?? "No Title")")
        print(marker.userData ?? "No user data")
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("Info Window: \(marker.title ?? "No Title")")
    }
}
