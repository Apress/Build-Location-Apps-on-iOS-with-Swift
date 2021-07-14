//
//  ViewController.swift
//  GoogleMapsApp
//
//  Created by Jeffrey Linwood on 1/17/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit

import GoogleMaps

struct GoogleDirectionsResponse: Codable {
    var routes: [Route]?
}

struct Route:Codable {
    var overview_polyline: OverviewPolyline?
}

struct OverviewPolyline: Codable {
    var points: String?
}

struct Coordinate: Codable {
    var lat: Float
    var lng: Float
}

class ViewController: UIViewController {

    let apiKey = "AIzaSyCwgB_IFPrdabFo_6HA3aL3WuIUIKM0ivI"

    var routePolyline: GMSPolyline?
    
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
        
        retrieveDirections()
    }
    
    func retrieveDirections() {
        
        let directionsUri = "https://maps.googleapis.com/maps/api/directions/json?origin=Austin,TX&destination=Houston,TX&key=\(apiKey)"
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: directionsUri) else {
            print("Could not parse directions URI into URL")
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Error returning data from url")
                print(error?.localizedDescription ?? "No error defined")
                return
            }
            self.processDirections(data)
        }
        task.resume()
    }
    
    func processDirections(_ data:Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(GoogleDirectionsResponse.self, from: data)
            print(response)
            guard let points = response.routes?.first?.overview_polyline?.points else {
                return
            }
            // displaying the polyline on the map has to be on the main thread
            DispatchQueue.main.async {
                self.displayOverviewPolyline(points)
            }
        }
        catch let error as NSError {
            print("JSON Error: \(error)")
        }
    }

    
    func displayOverviewPolyline(_ points: String) {
        guard let routePath = GMSPath(
            fromEncodedPath: points) else {
            return
        }
        let polyline = GMSPolyline(path: routePath)
        polyline.strokeColor = .red
        polyline.strokeWidth = 3
        polyline.map = mapView
        self.routePolyline = polyline
        updateMapBounds(routePath)
    }
    
    func updateMapBounds(_ routePath: GMSPath) {
        let bounds = GMSCoordinateBounds(path: routePath)
        let insets = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, with: insets)
        mapView.moveCamera(cameraUpdate)
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
