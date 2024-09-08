//
//  Trip.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/28/23.
//

import Foundation

extension CDTrip {
    
    var dates: [Date] {
        let dayInterval: Double = 60*60*24
        let calendar = Calendar.current
        
        let startofStartDate = calendar.startOfDay(for: startDate!)
        let startofEndDate = calendar.startOfDay(for: Date(timeInterval: dayInterval, since: endDate!))
        
        let components = calendar.dateComponents([.day], from: startofStartDate, to: startofEndDate)
        
        var dates: [Date] = []
        for index in 0..<components.day! {
            dates.append(Date(timeInterval: dayInterval * Double(index), since: startofStartDate))
        }
        return dates
    }
    
}

//struct Trip: Identifiable {
//    
//    let id: UUID
//    let name: String
//    let startDate: Date
//    let endDate: Date
//    var agendaItems: [Date:[AgendaItem]]
//    
//    var dates: [Date] { agendaItems.keys.sorted { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 } }
//    
//    init(id: UUID = UUID(), name: String, startDate: Date, endDate: Date) {
//        self.id = id
//        self.name = name
//        self.startDate = startDate
//        self.endDate = endDate
//        let dates = Self.datesOfTrip(startDate: startDate, endDate: endDate)
//        
//        var agendaItems: [Date: [AgendaItem]] = [:]
//        for date in dates {
//            agendaItems[date] = []
//        }
//        self.agendaItems = agendaItems
//    }
//    
//    static func datesOfTrip(startDate: Date, endDate: Date) -> [Date] {
//        
//        let dayInterval: Double = 60*60*24
//        let calendar = Calendar.current
//
//        let startofStartDate = calendar.startOfDay(for: startDate)
//        let startofEndDate = calendar.startOfDay(for: Date(timeInterval: dayInterval, since: endDate))
//        
//        let components = calendar.dateComponents([.day], from: startofStartDate, to: startofEndDate)
//        
//        var dates: [Date] = []
//        for index in 0..<components.day! {
//            dates.append(Date(timeInterval: dayInterval * Double(index), since: startofStartDate))
//        }
//        return dates
//    }
//}
//
//extension Trip {
//    
//    static let date1 = Date()
//    
//    static let testTrips = [
//        Trip(
//            name: "Dublin, Ireland",
//            startDate: Self.date1,
//            endDate: .init(timeInterval: 60*60*24*7, since: Self.date1)),
//        Trip(
//            name: "Paris, France",
//            startDate: .init(timeInterval: 60*60*24*14, since: Self.date1),
//            endDate: .init(timeInterval: 60*60*24*24, since: Self.date1))
//    ]
////
////    AgendaItem(name: "surfing", date: Date(), itemType: .attraction),
////    AgendaItem(name: "tacos", date: Date(), itemType: .food)
////    AgendaItem(name: "tacos", date: Date(), itemType: .food),
////    AgendaItem(name: "surfing", date: Date(), itemType: .attraction),
//}
