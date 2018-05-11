// created by Ward


import Foundation
import MapKit

class Producer {
    let companyName: String?
    let contact: Contact
//    still find out how to stock image in FireStore
//    var companyImage: String? = nil
//    in order to stock a String type in FireStore
//    optional because when there is no delivery they might not reveal their address
        var address: Address?
//    var location: CLLocationCoordinate2D
//    type CLLocation heeft methode distance
    var location: CLLocation
    var locationString: String
    var delivery: Bool
//    make drop down list in add Producer
    let mainProduce: MainProduce
//    turn Date type into string (timeintervalsince) in order to use in Firestore
//    this date schould specify in the date/time Picker day and starting hour of delivery and pickup
    let deliveryHour: Date?
    let pickUpHour: Date?
//    if there is still time to do we count the amount of validation stars commited by users
    var validation: Int?
    var stocks: [Stock]
//    var orderLists: [OrderList]
    var totalStockCost: Double {
        var totalCost = 0.0
        for stock in stocks {
            totalCost += stock.totalCostOfSelectedStock
        }
        return totalCost
    }
    var description: String   {
        if let companyName = companyName {
            return "\(companyName):\n\(contact.description)\nProducten: \(mainProduce.rawValue)"
        } else {
            return "(contact.description)\nProducten: \(mainProduce.rawValue)"
        }
    }
    
    init(companyName: String?, contact: Contact, companyImage: String?, location: CLLocation, locationString: String, delivery: Bool, mainProduce: MainProduce, deliveryHours: Date, pickUpHours: Date, validation: Int?, stocks: [Stock]) {
        self.companyName = companyName
        self.contact = contact
        self.companyImage = companyImage
        self.location = location
        self.locationString = locationString
        self.delivery = delivery
        self.mainProduce = mainProduce
        self.deliveryHour = deliveryHours
        self.pickUpHour = pickUpHours
        self.validation = validation
        self.stocks = stocks
        
    }
    
//    convenience initialiser
    
    convenience init(contact: Contact, location: CLLocation, locationString: String, address: Address, mainProduce: MainProduce, stocks: [Stock]) {
        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, locationString: locationString, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil, stocks: stocks)
        
        
//        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil)
    }
}

