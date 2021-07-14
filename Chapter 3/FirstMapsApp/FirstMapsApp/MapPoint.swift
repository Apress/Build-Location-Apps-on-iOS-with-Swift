//
//  MapPoint.swift
//  FirstMapsApp
//
//  Created by Jeffrey Linwood on 6/4/20.
//  Copyright © 2020 Jeff Linwood. All rights reserved.
//

import UIKit
import MapKit

class MapPoint: NSObject, MKAnnotation {
  @objc dynamic var coordinate: CLLocationCoordinate2D
  var title:String?
  var subtitle: String?

  init(coordinate:CLLocationCoordinate2D,
        title:String?, subtitle:String?) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
}
