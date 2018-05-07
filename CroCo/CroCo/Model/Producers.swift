//
//  Producers.swift
//  CroCo
//
//  Created by Ward Janssen on 06/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation
import CoreLocation

class Producers {
    private var producers: [Producer]?
    var deliveryLocation: CLLocation?
    
    private func sortProducersByDistanceToStartLocation(destinationProducerCrop: CLLocation)->[Producer] {
        guard let producers = producers else {return []}
        return producers.sorted(by: {(producer1, producer2) -> Bool in (producer1).location.distance(from: self.deliveryLocation!) <                                        (producer2).location.distance(from: self.deliveryLocation!)
        })
    }
}
