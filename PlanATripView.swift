//
//  PlanATripView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/28/23.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct PlanATripView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var searchString = ""
    
    @State private var startDate = Date()
    @State private var endDate = Date(timeInterval: 60*60*24*7, since: Date())
    
    @State private var mapRegion = MKCoordinateRegion(center: .init(latitude: 50.0, longitude: 50.0), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State private var markers : [Location] = []
    
    var body: some View {
        VStack(spacing: 20.0) {
            
            Text("Where are you going?")
                .font(.largeTitle)
            
            VStack(spacing: 10) {
                Map(coordinateRegion: $mapRegion, interactionModes: .all, annotationItems: markers) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Text(location.name)
                        Circle().fill(Color.red).frame(width: 10, height: 10)
                    }
                }
                .frame(height: 200.0)
                
                
                
                
                HStack {
                    TextField("Search", text: $searchString)
                        .background(Color.white)
                        .padding(2)
                        .background(Color.gray)
                    Button(action: searchPressed) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12.0, height: 12.0)
                    }
                    .disabled(searchString.isEmpty)
                }
            }
                .padding(.horizontal)
            
            VStack(spacing: 10) {
                Text("Date of Trip")
                    .font(.title)
                HStack(spacing: 8.0) {
                    Text("Start").font(.title3)
                    DatePicker("Start", selection: $startDate)
                        .labelsHidden()
                }
                HStack(spacing: 8.0) {
                    Text("End").font(.title3)
                    DatePicker("End", selection: $endDate)
                        .labelsHidden()
                }
                
                    
            }
            
            Button("Submit", action: submitPressed)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Plan A Trip")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.gray,for:.navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func searchPressed() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchString
        searchRequest.region = mapRegion
        
        MKLocalSearch(request: searchRequest).start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            mapRegion = response.boundingRegion
            markers = response.mapItems.map { item in
                Location(name: item.name ?? "", coordinate: item.placemark.coordinate)
            }
        }
    }
    
    func submitPressed() {
        let trip = CDTrip(context: context)
        trip.name = searchString
        trip.startDate = startDate
        trip.endDate = endDate
        let existringTrips: NSSet = appState.user!.trips ?? []
        appState.user!.trips = existringTrips.adding(trip) as NSSet
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        dismiss()
    }
}

