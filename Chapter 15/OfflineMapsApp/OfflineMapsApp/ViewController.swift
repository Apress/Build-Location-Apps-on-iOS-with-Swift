//
//  ViewController.swift
//  OfflineMapsApp
//
//  Created by Jeffrey Linwood on 4/29/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MGLMapView!
    var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.centerCoordinate = CLLocationCoordinate2D(
                  latitude: 30.2,
                  longitude: -97.75)
        mapView.zoomLevel = 10
        mapView.styleURL = MGLStyle.outdoorsStyleURL
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(offlinePackProgressChanged),
            name: NSNotification.Name.MGLOfflinePackProgressChanged,
            object: nil)
        
        downloadOfflineMapPack()
    }
    
    @objc func offlinePackProgressChanged(
        notification: NSNotification) {
        guard let pack = notification.object
            as? MGLOfflinePack else {
            return
        }
        
        let progress = pack.progress
        print("Offline pack progress changed")
        print(progress.countOfBytesCompleted)
        let percentageResources = Int(round(100 *
            Float(progress.countOfResourcesCompleted) /
            Float(progress.countOfResourcesExpected)))
        
        print("Resources: \(percentageResources)%")
    }
    
    func createOfflineRegionBounds() -> MGLCoordinateBounds {
        let southwest = CLLocationCoordinate2D(
            latitude: 28.822,
            longitude: -99.5934)
        let northeast = CLLocationCoordinate2D(
            latitude: 30.8611,
            longitude: -96.6051)
        return MGLCoordinateBounds(sw: southwest,
                                   ne: northeast)
    }
    
    func downloadOfflineMapPack() {
        let bounds = createOfflineRegionBounds()
        let region = MGLTilePyramidOfflineRegion(
            styleURL: mapView.styleURL,
            bounds: bounds,
            fromZoomLevel: 5,
            toZoomLevel: 8)
        
        let packName = "Central Texas"
        guard let nameData = packName.data(using: .utf8) else {
            return
        }
            
        MGLOfflineStorage.shared.addPack(
            for: region,
            withContext: nameData) { (pack, error) in
                guard let pack = pack else {
                    print("Unable to create pack")
                    print(error?.localizedDescription ??
                        "No error given")
                    return
                }
                pack.resume()
        }
    }
}

