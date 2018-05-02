//
//  FoodTypes.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

enum FoodTypes {
    case vegetable, meat, fruit
    // possibly change to a structure?
//    case vegetable: String {
//        case carrots = "Wortel", peas = "Erwten", corn = "Mais", strawberries = "Aardbeien", tomatoes = "Tomaten", bellPeppers = "Paprika"
//    }
//    case meat: String {
//        case cow = "Koe", horse = "Paard", goat = "Geit", lamb = "Lamb", pig = "Varken", deer = "Hert", boar = "Everzwijn", rabbit = "Konijn"
//    }
//
//    case fruit: String {
//        case oranges = "Sinaasappel", pears = "Peren", apples = "Appels", watermellon = "Watermeloen"
//    }
//
//
}
enum FoodName: String {
    case carrots = "Wortel", peas = "Erwten", corn = "Mais", strawberries = "Aardbeien", tomatoes = "Tomaten", bellPeppers = "Paprika"
    
    case cow = "Koe", horse = "Paard", goat = "Geit", lamb = "Lamb", pig = "Varken", deer = "Hert", boar = "Everzwijn", rabbit = "Konijn"
    
    case oranges = "Sinaasappel", pears = "Peren", apples = "Appels", watermellon = "Watermeloen"
}

//enum Vegetable: String, FoodTypes {
//    case carrot = "Wortel", pea = "Erwten", corn = "Mais", strawberrie = "Aardbeien", tomatoe = "Tomaten", bellPepper = "Paprika"
//}
