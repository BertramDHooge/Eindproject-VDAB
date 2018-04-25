//
//  Adress.swift
//  
//
//  Created by Ward on 25/04/2018.
//

import Foundation

struct Name {
    let firstName: String
    let lastName: String
}

enum Place: String {
    case werchter = "Werchter"
    case tremelo = "Tremelo"
    case oudHeverlee = "Oud Heverlee"
    case leuven = "Leuven"
    case betekom = "Betekom"
    case kesselLo = "Kessel-Lo"
    case herent = "Herent"
}

struct Address {
    let streetName: String
    let streetNumber: String
    let postalCode: String
    let place: Place
}

struct Contact {
    let name: Name
    let address: Address
    let telephoneNumber: String
    let emailAddress: String
}
