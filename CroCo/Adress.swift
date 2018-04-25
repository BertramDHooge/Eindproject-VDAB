//
//  Adress.swift
//  
//
//  Created by Ward on 25/04/2018.
//

import Foundation

enum Place: String {
    case "Werchter", "Tremelo", "Oud-Heverlee" "Leuven", "Betekom", "Kessel-Lo"
}

struct Adress {
    let streetName: String
    let streetNumber: String
    let postalCode: String
    let place: Place
}
