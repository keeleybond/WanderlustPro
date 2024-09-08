//
//  AddAgendaItemView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/11/23.
//

import SwiftUI
import MapKit

struct AddAgendaItemView: View {
    
    @Environment(\.managedObjectContext) var context
    
    var trip: CDTrip
    let agendaItemType: AgendaItemType
    
    @State private var selectedPlace: RadarResponse.RadarPlace?
    
    @State private var region : MKCoordinateRegion?
    @State private var markers : [Location] = []
    
    @State private var places: [RadarResponse.RadarPlace] = []
    
    var body: some View {
        VStack(spacing: 20.0) {
            VStack {
                Image(systemName: agendaItemType.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text(agendaItemType.rawValue)
                    .font(.title)
            }
                .padding(.vertical)
                .padding(.horizontal, 30)
                .background(Color.mint)
            Spacer()
            if let region {
                Map(coordinateRegion: Binding(get: { region }, set: { self.region = $0 }),
                    interactionModes: .all,
                    annotationItems: markers
                ){ location in
                    //MapMarker(coordinate: location.coordinate)
                    MapAnnotation(coordinate: location.coordinate) {
                        Text(location.name)
                        Circle().fill(Color.red).frame(width: 10, height: 10)
                    }
                }
                    .frame(height: 250)
            } else {
                Color.gray
                    .frame(height: 250)
            }
            Spacer()
            VStack {
                Text("Locations")
                    .font(.title2)
                if places.isEmpty {
                    Text("Loading...")
                        .frame(height: 200)
                } else {
                    List {
                        ForEach(places, id: \._id) { place in
                            HStack(spacing: 6.0) {
                                Text(place.name)
                                    .font(.title3)
                                Spacer()
                                Button(action: { addPlaceToDayPressed(place) }) {
                                    Text("Add to day")
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background(Color.gray)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.plain)
                                
                                Button(action: { placePressed(place) }) {
                                    Image(systemName: "location.magnifyingglass")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16.0, height: 16.0)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .frame(height: 200)
                }
            }
            
        }
            .padding()
            .sheet(item: $selectedPlace, content: { place in
                List {
                    ForEach(trip.dates, id: \.self) { date in
                        Text(titleOfDay(date: date))
                            .onTapGesture {
                                let agendaItem = CDAgendaItem(context: context)
                                agendaItem.name = selectedPlace!.name
                                agendaItem.date = date
                                agendaItem.agendaItemType = agendaItemType.rawValue
                                
                                var currentAgendaItems = trip.agendaItems!
                                currentAgendaItems = currentAgendaItems.adding(agendaItem) as NSSet
                                trip.agendaItems = currentAgendaItems
                                do {
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                
                                selectedPlace = nil
                            }
                    }
                }
            })
            .task {
                forwardGeocoding()
            }
    }
    
    func addPlaceToDayPressed(_ place: RadarResponse.RadarPlace) {
        selectedPlace = place
    }
    
    func placePressed(_ place: RadarResponse.RadarPlace) {
        let coords = CLLocationCoordinate2D(latitude: place.location.coordinates[1], longitude: place.location.coordinates[0])
        withAnimation {
            region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }
    
    func forwardGeocoding() {
            
        let addressString = trip.name!
        
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
                                            {(placemarks, error) in
            
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                
                DispatchQueue.main.async {
                    region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//                        let location = Location(name: placemark.locality!, coordinate: coords)
//                        markers.append(location)
                    
                    Network.getPlaces(agendaItemType: agendaItemType, latitude: coords.latitude, longitude: coords.longitude) { places in
                        
                        DispatchQueue.main.async {
                            
                            self.places = places
                            markers = places.map { item in
                                return Location(
                                    name: item.name,
                                    coordinate: CLLocationCoordinate2D(latitude: item.location.coordinates[1], longitude: item.location.coordinates[0])
                                )
                            }
                        }
                    }
                }
            }
        })
    }
    
    func titleOfDay(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
}


