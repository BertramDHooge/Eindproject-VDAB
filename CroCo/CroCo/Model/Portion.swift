//
//  Portion.swift
//  CroCo
//
//  Created by Louis Loeckx on 08/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

struct Portion {
// This is future proof model but to get the first sprint we make a portion with name, quantityType and portionQuantity all in one together with an adaptable price
    
//    var stockName: StockName
//    var stockType: StockTypes
//    var standardisedQuantitySingleStockType: QuantityTypes
//    // this is the amount off portions the producer has in stock - warning: not the real quantity of this Foodtype. The real quantity is times quantityType this number
//    var totalPortionsInStock: Int
    // this should be added:
    
    var weight: Int
    var typeOfWeight: String
    var typeOfWeightAndWeightPerPortion: String {
        return "\(weight) \(typeOfWeight)"
    }
    var stockName: String
    var sellingPriceSinglePortion: Double
}
