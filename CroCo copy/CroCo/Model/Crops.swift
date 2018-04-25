//
//  Crops.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

enum vegetables: String {
    case carrots = "Wortel", peas = "Erwten", corn = "Mais", watermellon = "Watermeloen", strawberries = "Aardbeien", oranges = "Sinaasappel", apples = "Appels", pears = "Peren", tomatoes = "Tomaten", bellPeppers = "Paprika"
}

enum quantity: Int {
    case _1000 = 1000, _500 = 500, _300 = 300, _250 =  250, _100 = 100, _50 = 50
}
enum typeOfQuantity{
    case kg, g, bussel, pieces
}

enum meat: String {
    case cow = "Koe", horse = "Paard", goat = "Geit", lamb = "Lamb", pig = "Varken", deer = "Hert", boar = "Everzwijn", rabbit = "Konijn"
}

struct Crop {
    var cropName: vegetables
    var quantity: quantity
    var typeOfQuantity: typeOfQuantity
    var cost: Double
}
