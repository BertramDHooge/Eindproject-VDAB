//
//  Producer.swift
//  CroCo
//
//  Created by Louis Loeckx on 24/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation
import MapKit

private class Producer {
        let companyName: String?
        let contact: Contact
        let companyImage: String? = nil
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 5, longitude: 50)
        let delivery: Bool
        let mainProduce: MainProduce
        let deliveryHours: Date?
        let pickUpHours: Date?
        var validation: Int?
        var description: String   
        init (companyName: String?, contact: Contact, companyImage: String?, location: CLLocationCoordinate2D, delivery: Bool, mainProduce: MainProduce, deliveryHours: Date, pickUpHours: Date, validation: Int?) {
            self.companyName = companyName
            self.contact = contact
            self.companyImage = companyImage
            self.location = location
            self.delivery = delivery
            self.mainProduce = mainProduce
            self.deliveryHours = deliveryHours
            self.pickUpHours = pickUpHours
            self.validation = validation
        }
        convenience init(contact: Contact, location: CLLocationCoordinate2D, mainProduce: MainProduce) {
            self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: false, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil)
        }
    
}
