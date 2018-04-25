//
//  Adress.swift
//  
//
//  Created by Ward on 25/04/2018.
//

import Foundation

struct Name {
    let surName: String
    let lastName: String
}

enum Place: String {
    case werchter = "Werchter"
    case tremelo = "Tremelo"
    case oudHeverlee = "Oud Heverlee"
    case Leuven
    case Betekom
    case KesselLo = "Kessel-Lo"
}

struct Adress {
    let streetName: String
    let streetNumber: String
    let postalCode: String
    let place: Place
}

struct Contact {
    let name: Name
    let adress: Adress
    let telephoneNumber: String
    let emailAdress: String
}
