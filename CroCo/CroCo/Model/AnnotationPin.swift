//
//  Annotation.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//
//TODO: herbekijken 

import UIKit
import MapKit

class AnnotationPin: NSObject, MKAnnotation {
    let producer: Producer
    
    init(with producer: Producer) {
        self.producer = producer
    }
    
    var title: String? {
        return producer.companyName ?? producer.contact.name.firstName
    }
    
    var subtitle: String? {
        if title != producer.companyName {
            return nil
        }
        return producer.contact.name.firstName
    }
    
    var coordinate: CLLocationCoordinate2D {
        return producer.location!.coordinate
//        return CLLocationCoordinate2D(latitude: producer.location.coordinate.latitude, longitude: producer.location.coordinate.longitude)
        
    }
    
    var annotationColor: UIColor {
        switch producer.mainProduce {
        case .dairy:
            return .white
        case .eggs:
            return .yellow
        case .fruit:
            return .red
        case .meat:
            return .brown
        case .poultry:
            return .brown
        case .vegetable:
            return .green
        default:
            return .white
        }
    }
    
    
}
