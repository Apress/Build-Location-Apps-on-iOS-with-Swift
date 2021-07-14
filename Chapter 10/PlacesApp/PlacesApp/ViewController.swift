//
//  ViewController.swift
//  PlacesApp
//
//  Created by Jeffrey Linwood on 5/6/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(
                 withLatitude: 30.25,
                 longitude: -97.75,
                 zoom: 12)
        mapView.animate(to: camera)
        mapView.mapType = .normal
    }


    @IBAction func findBusinesses(_ sender: Any) {
        let vc = GMSAutocompleteViewController()
        vc.delegate = self
        
        // search for places in this area
        let region = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds.init(region: region)
        vc.autocompleteBounds = bounds
        
        // only return results visible on the map
        vc.autocompleteBoundsMode = .restrict
        
        // needed for the map marker
        let fields = UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue)
        
        guard let placeFields = GMSPlaceField(rawValue: fields) else {
            return
        }
        
        // only return asked for fields
        vc.placeFields = placeFields
        
        // we are looking for businesses/points of interest
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        vc.autocompleteFilter = filter
        
        // display as modal
        present(vc, animated: true, completion: nil)
    }
    
    func addMarker(_ place:GMSPlace) {
        let marker = GMSMarker()
        marker.position = place.coordinate
        marker.title = place.name
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.userData = place
        marker.map = mapView
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController:
        GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true,
                               completion: nil)
        print(place)
        print(place.attributions ?? "No attributions")
        addMarker(place)
    }
    
    func viewController(_ viewController:
        GMSAutocompleteViewController,
                        didFailAutocompleteWithError error: Error) {
        viewController.dismiss(animated: true,
                               completion: nil)
    }
    
    func wasCancelled(_ viewController:
        GMSAutocompleteViewController) {
        viewController.dismiss(animated: true,
                               completion: nil)
    }
}

