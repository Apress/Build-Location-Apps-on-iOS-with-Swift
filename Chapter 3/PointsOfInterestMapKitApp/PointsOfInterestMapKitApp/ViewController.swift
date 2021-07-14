//
//  ViewController.swift
//  PointsOfInterestMapKitApp
//
//  Created by Jeffrey Linwood on 10/12/19.
//  Copyright © 2019 Jeff Linwood. All rights reserved.
//

import UIKit

import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        mapView.register(MKAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: "DogPark")
        
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
    }
    
    class MapPoint: NSObject, MKAnnotation {
        @objc dynamic var coordinate: CLLocationCoordinate2D
        var title:String?
        var subtitle: String?
        var imageName: String?
        
        init(coordinate:CLLocationCoordinate2D,
             title:String?, subtitle:String?) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
        }
    }
    
}

extension ViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation)
        -> MKAnnotationView? {
        let reuseId = "DogPark"
        let view = mapView.dequeueReusableAnnotationView(
            withIdentifier: reuseId)
        view?.annotation = annotation
        view?.image = UIImage(named:"DogPark")
        view?.canShowCallout = true
            view?.rightCalloutAccessoryView = UIButton()
        return view
    }
}


