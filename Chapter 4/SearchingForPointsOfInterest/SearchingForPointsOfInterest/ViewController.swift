//
//  ViewController.swift
//  SearchingForPointsOfInterest
//
//  Copyright © 2019 Jeff Linwood. All rights reserved.
//

import UIKit

import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mapView.region.span.latitudeDelta = 0.1
        self.mapView.region.span.longitudeDelta = 0.1

        
        
        //searchForCoffee()
        //searchForCoffeeOnMap()
        searchForBakeriesOnMap()
    }

    func searchForCoffee() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "coffee"
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print("Error searching - no response")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("No error specified")
                }
                return
            }
            
            for mapItem in response.mapItems {
                print(mapItem.name ?? "No name specified")
            }
        }
    }
    
    func searchForCoffeeOnMap() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "coffee"
        searchRequest.region = mapView.region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print("Error searching - no response")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("No error specified")
                }
                return
            }
            
            for mapItem in response.mapItems {
                self.mapView.addAnnotation(mapItem.placemark)
            }
            
            self.mapView.setRegion(response.boundingRegion, animated: true)
        }
    }
    
    func searchForBakeriesOnMap() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.pointOfInterestFilter = MKPointOfInterestFilter(including: [.bakery])
        searchRequest.region = mapView.region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print("Error searching - no response")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("No error specified")
                }
                return
            }
            
            for mapItem in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                annotation.subtitle = mapItem.phoneNumber
                self.mapView.addAnnotation(annotation)
            }
            
            self.mapView.setRegion(response.boundingRegion, animated: true)
        }
    }

}

