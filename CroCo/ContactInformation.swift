//
//  Adress.swift
//  
//
//  Created by Ward on 25/04/2018.
//

import Foundation

class Name: CustomStringConvertible {
    let firstName: String
    let lastName: String
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    var fullName: String {
        return "(\(firstName) \(lastName)"
    }
    var description: String {
        return fullName
    }
}

enum Place: String {
    case werchter = "Werchter"
    case tremelo = "Tremelo"
    case oudHeverlee = "Oud Heverlee"
    case leuven = "Leuven"
    case betekom = "Betekom"
    case kesselLo = "Kessel-Lo"
    case herent = "Herent"
    case wilsele = "Wilsele"
}

class Address: CustomStringConvertible {
    let streetName: String
    let streetNumber: String
    let postalCode: String
    let place: Place
    init(streetName: String, streetNumber: String, postalCode: String, place: Place){
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.postalCode = postalCode
        self.place = place
    }
    var fullAdress: String {
        return "\(streetName) \(streetNumber)\n\(postalCode) \(place.rawValue)"
    }
    var description: String {
        return fullAdress
    }
}

class Contact: CustomStringConvertible {
    var description: String
    
    let name: Name
    let address: Address
    let telephoneNumber: String?
    let emailAddress: String?
    init(name: Name, address: Address, telephoneNumber: String, emailAddress: String) {
        self.name = name
        self.address = address
        self.telephoneNumber = telephoneNumber
        self.emailAddress = emailAddress
    }
    var fullContactData: String {
        return "\(name.description)\n\(address.description)\ntelefoonnummer:\(String(describing: telephoneNumber))\nemail:\(String(describing: emailAddress)) "
    }
}
