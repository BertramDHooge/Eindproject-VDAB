//
//  Annotation.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

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
        if title == producer.companyName {
            return nil
        }
        return producer.contact.name.firstName
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: producer.location.coordinate.latitude, longitude: producer.location.coordinate.longitude)
        
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
        case .vegetableFruit:
            return .green
        case .vegetabledairy:
            return .green
        case .vegetableEggs:
            return .green
        case .vegetablePoultry:
            return .green
        case .fruitDairy:
            return .green
        case .fruitEggs:
            return .green
        case .fruitPoultry:
            return .green
        case .meatVegetable:
            return .green
        case .meatFruit:
            return .green
        case .meatDairy:
            return .green
        case .meatEggs:
            return .green
        case .meatPoultry:
            return .green
        case .EggsPoultry:
            return .green
        case .meatVegetableFruit:
            return .green
        case .vegetableFruitEggs:
            return .green
        case .vegetableFruitDairy:
            return .green
        case .vegetableFruitPoultry:
            return .green
        case .meatFruitEggs:
            return .green
        case .meatFruitPoultry:
            return .green
        case .meatDairyEggs:
            return .green
        case .meatFruitdairy:
            return .green
        case .meatDairyPoultry:
            return .green
        case .meatVegetableFruitdairy:
            return .green
        case .meatVegetableFruitEggs:
            return .green
        case .meatVegetableFruitPoultry:
            return .green
        case .vegetableFruitEggsPoultry:
            return .green
        case .vegetableFruitdairyEggs:
            return .green
        case .meatDairyEggsPoultry:
            return .green
        case .vegetableFruitdairyEggsPoultry:
            return .green
        case .meatVegetableFruitdairyEggs:
            return .green
        }
    }
    
    
}
