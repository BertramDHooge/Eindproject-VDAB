//
//  Place.swift
//  CroCo
//
//  Created by Ward Janssen on 06/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation
import CoreLocation
struct Plaats {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    var location: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
    
}
