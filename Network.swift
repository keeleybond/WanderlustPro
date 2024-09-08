//
//  Network.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/11/23.
//

import Foundation

class Network {


    static func getPlaces(agendaItemType: AgendaItemType, latitude: Double, longitude: Double, completion: @escaping ([RadarResponse.RadarPlace]) -> Void) {
        
        let category: String
        switch agendaItemType {
        case .food: category = "food-beverage"
        case .attraction: category = "arts-entertainment"
        }
        
        let url = URL(string: "https://api.radar.io/v1/search/places?categories=\(category)&near=\(latitude),\(longitude)&radius=10000&limit=100")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("prj_test_sk_0a06a1d6ae06862a2d55af6120ab452c301e5158", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print(error!, error!.localizedDescription)
                return
            }
            
            guard let data else {
                print("Data was nil")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RadarResponse.self, from: data)
                completion(response.places)
            } catch {
                print(error, error.localizedDescription)
            }
            
        }.resume()
    }
}
