//
//  Crops.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

// ik denk dat we best een file crops maken waarin een array van crop in zit - Ward

struct Crop {
    var cropType: FoodTypes
    var cropName: FoodName
    var quantityTypes: QuantityTypes
    var quantity: Quantity
    var cost: Double
    var amountOfCropPortionsAvailable: Int
}
