//
//  AgendaView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/10/23.
//

import SwiftUI

struct AgendaView: View {
    
    @ObservedObject var trip: CDTrip
    
    private var destinationString: String{
        "Trip: " + trip.name!
    }
    
    var body: some View {
        VStack(spacing:20){
            Text("Agenda")
                .font(.title)
            Text(destinationString)
                .foregroundColor(Color.red)
            VStack{
                Divider()
                NavigationLink("Food") {
                    AddAgendaItemView(trip: trip, agendaItemType: .food)
                }
                Divider()
                NavigationLink("Attractions") {
                    AddAgendaItemView(trip: trip, agendaItemType: .attraction)
                }
                Divider()
            }
            Spacer()
            VStack{
                Text("Weekly Planner")
                    .font(.title)
                List{
                    ForEach(trip.dates, id: \.self) { date in
                        DisclosureGroup(titleOfDay(date: date)) {
                            AgendaDayView(agendaItems: agendaItems(forDate: date))
                        }
                    }
                }
            }
        }
    }
    
    func titleOfDay(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func agendaItems(forDate date: Date) -> [CDAgendaItem] {
        trip.agendaItems!.filter { ($0 as! CDAgendaItem).date! == date  }
            .sorted { ($0 as! CDAgendaItem).name! < ($1 as! CDAgendaItem).name! } as! [CDAgendaItem]
    }
}


