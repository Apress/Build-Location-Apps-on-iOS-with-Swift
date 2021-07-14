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
    }
}

