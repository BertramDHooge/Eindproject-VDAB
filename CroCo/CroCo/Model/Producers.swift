//
//  Producers.swift
//  CroCo
//
//  Created by Ward Janssen on 06/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation
import MapKit

class Producers {
    let companyName: String?
    let contact: Contact
    //    still find out how to stock image in FireStore
    var companyImage: String? = nil
    //    in order to stock a String type in FireStore
    //    optional because when there is no delivery they might not reveal their address
    var address: Address?
    //    var location: CLLocationCoordinate2D
    //    type CLLocation heeft methode distance
    var location: CLLocation
    var locationString: String
    var delivery = false
    //    make drop down list in add Producer
    let mainProduce: MainProduce
    //    turn Date type into string (timeintervalsince) in order to use in Firestore
    //    this date schould specify in the date/time Picker day and starting hour of delivery and pickup
    let deliveryHour: String?
    let pickUpHour: String?
    //    if there is still time to do we count the amount of validation stars commited by users
    //    var validation: Int?
    var stocks: [Stock]
    //    var orderLists: [OrderList]
    var description: String   {
        if let companyName = companyName {
            return "\(companyName):\n\(contact.description)\nProducten: \(mainProduce.rawValue)"
        } else {
            return "(contact.description)\nProducten: \(mainProduce.rawValue)"
        }
    }
    
    init(companyName: String?, contact: Contact, location: CLLocation, locationString: String, delivery: Bool, mainProduce: MainProduce, deliveryHours: String, pickUpHours: String, stocks: [Stock]) {
        self.companyName = companyName
        self.contact = contact
        self.location = location
        self.locationString = locationString
        self.delivery = delivery
        self.mainProduce = mainProduce
        self.deliveryHour = deliveryHours
        self.pickUpHour = pickUpHours
        self.stocks = stocks
        
    }
    
    //    convenience initialiser
    
    convenience init(contact: Contact, location: CLLocation, locationString: String, address: Address, mainProduce: MainProduce, stocks: [Stock]) {
        self.init(companyName: nil, contact: contact, location: location, locationString: locationString, delivery: true, mainProduce: mainProduce, deliveryHours: "", pickUpHours: "", stocks: stocks)
        
        
        //        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil)
    }

}
