//
//  ViewController.swift
//  MapboxNavigationApp
//
//  Created by Jeffrey Linwood on 4/26/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit

import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getDirections()
        startNavigation()
    }
    
    func createWaypoints() -> [Waypoint] {
        let austinCoordinate = CLLocationCoordinate2D(
                   latitude: 30.27, longitude: -97.74)
        let alamoCoordinate = CLLocationCoordinate2D(
           latitude: 29.426, longitude: -98.486)

        let austin = Waypoint(coordinate: austinCoordinate,
                             name: "Austin")
        let alamo = Waypoint(coordinate: alamoCoordinate,
                            name: "The Alamo")
        return [austin, alamo]
    }
    
    func getDirections() {
        
        let waypoints = createWaypoints()
        let options = RouteOptions(waypoints: waypoints,
                                   profileIdentifier: .automobile)
        options.includesSteps = true

        Directions.shared.calculate(options) {
            (waypoints, routes, error) in
            guard let route = routes?.first else {
                print(error ?? "No Error")
                return
            }
            guard let firstLeg = route.legs.first else {
                return
            }
            print(firstLeg.name)
            for step in firstLeg.steps {
                print(step.instructions)
            }
        }
    }
    
    func startNavigation() {
        let waypoints = createWaypoints()
        let options = NavigationRouteOptions(
            waypoints:waypoints)
        options.roadClassesToAvoid = [.toll]

        Directions.shared.calculate(options) {
            (waypoints, routes, error) in
            guard let route = routes?.first else {
                print(error ?? "No error")
                return
            }
            let navService = MapboxNavigationService(
                route: route, simulating: .always)
            let navOptions = NavigationOptions(
                navigationService: navService)
            let navVC = NavigationViewController(for: route,
                                                 options: navOptions)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC,
                         animated: true,
                         completion: nil)
        }
    }


}

