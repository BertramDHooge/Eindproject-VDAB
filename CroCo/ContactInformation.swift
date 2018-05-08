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

class Address: CustomStringConvertible {
    
    let streetName: String
    let streetNumber: Int
    let postalCode: Int
    let place: String
    init(streetName: String, streetNumber: Int, postalCode: Int, place: String){
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.postalCode = postalCode
        self.place = place
    }
    var fullAdress: String {
        return "\(streetName) \(streetNumber)\n\(postalCode) \(place)"
    }
    var description: String {
        return fullAdress
    }
}

class Contact: CustomStringConvertible {
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
        return "\(name)\n\(address)\ntelefoonnummer:\(String(describing: telephoneNumber))\nemail:\(String(describing: emailAddress)) "
    }
    var description: String {
        return fullContactData
    }
}
