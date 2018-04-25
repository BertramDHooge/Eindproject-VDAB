//
//  Crops.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

enum quantity: Int {
    case _1000 = 1000, _500 = 500, _300 = 300, _250 =  250, _100 = 100, _50 = 50
}
enum typeOfQuantity{
    case kg, g, bussel, pieces
}

struct Good {
    var cropName: FoodTypeAndName
    var quantity: quantity
    var typeOfQuantity: typeOfQuantity
    var cost: Double
}
