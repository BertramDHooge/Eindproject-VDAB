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
    let companyName: String
    let producerName: String?
    let companyImage: String
    let description: String
    let address: CLLocationCoordinate2D
    let delivery: Bool
    let mainProduce: MainProduce
    let openHours: String
}
