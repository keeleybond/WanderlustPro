//
//  TripView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/28/23.
//

import SwiftUI

struct TripView: View {
    
    let trip: CDTrip
    
    private let dateFormatter = DateFormatter()
    
    private var dateString: String {
        
        dateFormatter.dateFormat = "MMMM d"
        return "Date of trip: " + dateFormatter.string(from: trip.startDate!) + " - " + dateFormatter.string(from: trip.endDate!)
    }
    
    var body: some View {
        VStack(spacing: 10.0) {
            Text(trip.name!).font(.title)
            Image("plane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100.0)
            HStack(spacing: 10.0) {
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.0, height: 20.0)
                Text(dateString)
            }
        }
    }
}

