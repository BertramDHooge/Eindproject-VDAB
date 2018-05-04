//
//  Crops.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation


struct Crop {
    var cropType: FoodTypes
    var cropName: FoodName
    var quantityTypes: QuantityTypes
    var quantity: Quantity
    var cost: Double
    var amountOfCropPortionsAvailable: String
}
