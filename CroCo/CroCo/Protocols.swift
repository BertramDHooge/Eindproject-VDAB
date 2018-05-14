//
//  Protocals.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 08/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

/// A type that allows a total amount to be changed
protocol ShoppingCartDelegate {
    
    func changeTotalAmount(by amountOfMoney: Double)
}

protocol AddStockDelegate {
    
    func addStock(_ stock: Stock)
}
