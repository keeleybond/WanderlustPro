//
//  AgendaFoodItem.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/10/23.
//

import Foundation

enum AgendaItemType: String {

    case food = "Food", attraction = "Attraction"

    var imageName: String{
        switch self{
        case .food:
            return "fork.knife"
        case .attraction:
            return "figure.surfing"
        }
    }
}

//struct AgendaItem: Identifiable{
//
//
//
//    let id: UUID
//    let name: String
//    let date: Date
//    let itemType: ItemType
//
//    init(id: UUID = UUID(), name: String, date: Date, itemType: ItemType) {
//        self.id = id
//        self.name = name
//        self.date = date
//        self.itemType = itemType
//    }
//}
