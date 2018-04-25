//
//  Annotation.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation
import MapKit

class AnnotationPin: NSObject, MKAnnotation {
    let producer: Producer
    
    init(with producer: Producer) {
        self.producer = producer
    }
    
    
    var title: String? {
        return producer.companyName
    }
    
    var subtitle: String? {
        return producer.producerName
    }
    
    var coordinate: CLLocationCoordinate2D {
        return producer.address
    }
}
