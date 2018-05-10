//
//  Portion.swift
//  CroCo
//
//  Created by Louis Loeckx on 08/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

struct Portion {

    var cropName: FoodName
    var cropType: FoodTypes
    var standardisedQuantitySingleCropType: QuantityTypes
    // this is the amount off portions the producer has in stock - warning: not the real quantity of this Foodtype. The real quantity is times quantityType this number
    var totalPortionsInStock: Int
    var sellingPriceSinglePortion: Double
}
