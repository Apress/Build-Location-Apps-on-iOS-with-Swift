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
        
        let point1 = MapPoint(
          coordinate: CLLocationCoordinate2D(latitude: 33.0,
            longitude: -97.0),
          title: "Point 1",
          subtitle: "Description 1"
        )
        mapView.addAnnotation(point1)

        let point2 = MapPoint(
          coordinate: CLLocationCoordinate2D(latitude: 32.0,
            longitude: -98.0),
          title: "Point 2",
          subtitle: "Description 2"
        )
        mapView.addAnnotation(point2)
        
        mapView.delegate = self

        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Pin")
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "DogPark")

    }
}

extension ViewController:MKMapViewDelegate {
 /*   func mapView(_ mapView: MKMapView,
      viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      if annotation is MKUserLocation {
        return nil
      }

      let reuseId = "Pin"
      if let pin = mapView.dequeueReusableAnnotationView(
          withIdentifier: reuseId)
        as? MKPinAnnotationView {

        pin.annotation = annotation
        pin.pinTintColor = UIColor.blue
        return pin
      } else {
        return nil
      }
    }*/
    func mapView(_ mapView: MKMapView,
      viewFor annotation: MKAnnotation)
        -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        }
      let reuseId = "DogPark"
      let view = mapView.dequeueReusableAnnotationView(
          withIdentifier: reuseId)
      view?.annotation = annotation
      view?.image = UIImage(named:"DogPark")
      view?.canShowCallout = true

      return view
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

