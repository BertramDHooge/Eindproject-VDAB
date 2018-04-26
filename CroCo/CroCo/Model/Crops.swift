//
//  Crops.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

struct Quantity{
    enum Kg: Int{
        case _20 = 20, _10 = 10, _5 = 5, _2 = 2, _1 = 1
    }
    enum Grams: Int {
        case _1000 = 1000, _500 = 500, _250 = 250, _100 = 100, _50 = 50, _25 = 25
    }
    enum Bussel: Int {
        case _25 = 25, _20 = 20, _10 = 10, _5 = 5, _1 = 1
    }
    enum Piece: Int {
        case _50 = 50, _25 = 25, _20 = 20, _10 = 10, _5 = 5, _1 = 1
    }
}

struct Good {
    var cropName: FoodTypeAndName
    var quantity:Quantity
    var cost: Double
}
