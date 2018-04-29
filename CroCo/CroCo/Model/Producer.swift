//
//  Producer.swift
//  CroCo
//
//  Created by Louis Loeckx on 24/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation
import MapKit

struct Producer {
    let companyName: String?
    let contact: Contact
    let companyImage: String
    let description: String
    let location: CLLocationCoordinate2D
    let delivery: Bool
    let mainProduce: MainProduce
    let deliveryHours: Date?
    let pickUpHours: Date
    var favorite: Bool = false
//    let crops: [Crop]
}
