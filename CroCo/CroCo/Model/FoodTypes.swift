//
//  FoodTypes.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

struct FoodTypeAndName {
    // possibly change to a structure?
    enum vegetables: String{
        case carrots = "Wortel", peas = "Erwten", corn = "Mais", watermellon = "Watermeloen", strawberries = "Aardbeien", oranges = "Sinaasappel", apples = "Appels", pears = "Peren", tomatoes = "Tomaten", bellPeppers = "Paprika"
    }
    enum meat: String {
        case cow = "Koe", horse = "Paard", goat = "Geit", lamb = "Lamb", pig = "Varken", deer = "Hert", boar = "Everzwijn", rabbit = "Konijn"
    }
    
    
}
