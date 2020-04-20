//
//  LandmarkAnnotation.swift
//  NearMeApp
//
//  Created by Mohammad Azam on 3/25/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
    
}
