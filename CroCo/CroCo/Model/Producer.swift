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
    var crops: [Crop]
    var description: String   {
        if let companyName = companyName {
            return "\(companyName):\n\(contact.description)\nProducten: \(mainProduce.rawValue)"
        } else {
            return "(contact.description)\nProducten: \(mainProduce.rawValue)"
        }
    }
    
    init(companyName: String?, contact: Contact, companyImage: String?, location: CLLocationCoordinate2D, delivery: Bool, mainProduce: MainProduce, deliveryHours: Date, pickUpHours: Date, validation: Int?, crops: [Crop]) {
        self.companyName = companyName
        self.contact = contact
        self.companyImage = companyImage
        self.location = location
        self.delivery = delivery
        self.mainProduce = mainProduce
        self.deliveryHours = deliveryHours
        self.pickUpHours = pickUpHours
        self.validation = validation
        self.crops = crops
    }
    convenience init(contact: Contact, location: CLLocationCoordinate2D, mainProduce: MainProduce, crop: [Crop]) {
        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crops: crop)
        
    func distanceToStartInMeters(_startLocation: CLLocation)->Double {
            
        }
        
//        self.init(companyName: nil, contact: contact, companyImage: nil, location: location, delivery: true, mainProduce: mainProduce, deliveryHours: Date(), pickUpHours: Date(), validation: nil)
    }
}

