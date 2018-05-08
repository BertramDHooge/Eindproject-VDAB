// created by Ward


import Foundation
import MapKit

class Producer {
    let companyName: String?
    let contact: Contact
    var companyImage: String? = nil
//    var location: CLLocationCoordinate2D
//    type CLLocation heeft methode distance
    var location: CLLocation
    var delivery: Bool
    let mainProduce: MainProduce
    let deliveryHours: Date?
    let pickUpHours: Date?
    var validation: Int?
    var stocks: [Stock]
//    var orderLists: [OrderList]
    var totalCropsCost: Double {
        var totalCost = 0.0
        for stock in stocks {
            totalCost += stock.totalCostOfCropsSelected
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
    
    init(companyName: String?, contact: Contact, companyImage: String?, location: CLLocation, delivery: Bool, mainProduce: MainProduce, deliveryHours: Date, pickUpHours: Date, validation: Int?, stocks: [Stock]) {
        self.companyName = companyName
        self.contact = contact
        self.companyImage = companyImage
        self.location = location
        self.delivery = delivery
        self.mainProduce = mainProduce
        self.deliveryHours = deliveryHours
        self.pickUpHours = pickUpHours
        self.validation = validation
        self.stocks = stocks
    }
    convenience init(contact: Contact, location: CLLocation, mainProduce: MainProduce, stocks: [Stock]) {
        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil, stocks: stocks)
        
        
//        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil)
    }
}

