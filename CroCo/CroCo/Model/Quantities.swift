//
//  Quantities.swift
//  CroCo
//
//  Created by Louis Loeckx on 26/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

enum QuantityTypes: String {
    case kg = "Kg", grams = "Grams", bussel = "Bussel", piece = "Piece(s)"
}

enum Quantity: Int {
    case _1000 = 1000, _500 = 500, _250 = 250, _100 = 100, _50 = 50, _25 = 25, _20 = 20, _10 = 10, _5 = 5, _2 = 2, _1 = 1
}
