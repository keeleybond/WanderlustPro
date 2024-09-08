//
//  UpcomingTripsView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/28/23.
//

import SwiftUI

struct UpcomingTripsView: View {
    
    @EnvironmentObject var appState: AppState
    
    var trips: [CDTrip] {
        
        guard let trips = appState.user!.trips else { return [] }
        
        let sortedTrips = trips.sorted { trip1, trip2 in
            return (trip1 as! CDTrip).startDate! < (trip2 as! CDTrip).startDate!
        }
        return (sortedTrips as! [CDTrip])
    }
    
                         
    var body: some View {
        VStack {
            Text("Upcoming Trips")
            List {
                ForEach(trips) { trip in
                    NavigationLink {
                        AgendaView(trip: trip)
                    } label: {
                        TripView(trip: trip)
                    }
                }
            }
            
        }
        .padding()
    }
}
