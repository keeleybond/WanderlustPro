//
//  RadarResponse.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/11/23.
//

import Foundation

struct RadarResponse: Codable {
    
    struct RadarPlace: Codable, Identifiable {
        
        struct RadarLocation: Codable {
            let type: String
            let coordinates: [Double]
        }
        
        var id: String { _id }
        
        let _id: String
        let name: String
        let location: RadarLocation
    }
    
    let places: [RadarPlace]
}

//
//{
//    \"meta\":{
//        \"code\":200
//    },
//    \"places\":[
//        {
//            \"_id\":\"5f663bb5618655405bf869a9\",
//            \"name\":\"Bluestone Lane\",
//            \"location\":{
//                \"type\":\"Point\",
//                \"coordinates\":[
//                    -73.977734,
//                    40.783646
//                ]
//        },
//    \"categories\":[
//        \"food-beverage\",
//        \"restaurant\"
//    ]
//}
//,{\"_id\":\"5f66ae8c618655405bef3239\",\"name\":\"Saravana Bhavan\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.97775383930512,40.78359028871019]},\"categories\":[\"food-beverage\",\"restaurant\"],\"chain\":{\"slug\":\"saravana-bhavan\",\"name\":\"Saravana Bhavan\",\"domain\":\"saravanabhavanlondon.co.uk\"}},{\"_id\":\"5f6652b5618655405b333d66\",\"name\":\"Swagat\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.97779423961335,40.78353541332511]},\"categories\":[\"food-beverage\",\"restaurant\"]},{\"_id\":\"5f66754a618655405b86932e\",\"name\":\"Made In New York Pizza\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.977566,40.783886]},\"categories\":[\"food-beverage\",\"restaurant\"]},{\"_id\":\"612510ce3520f05fce4cc0f0\",\"name\":\"Revolucion Tacos\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.977839,40.784107]},\"categories\":[\"food-beverage\",\"restaurant\"]},{\"_id\":\"645bdf29b0cc014685ffc360\",\"name\":\"7th Street Burger\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.977841,40.784111]},\"categories\":[\"food-beverage\",\"restaurant\"]},{\"_id\":\"6165a9fb9440726323821a30\",\"name\":\"The Hoptimist\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.97787,40.784086]},\"categories\":[\"food-beverage\",\"bar\"]},{\"_id\":\"5fa624497c1cf107fec55fe4\",\"name\":\"Joe\'s Steam Rice Roll\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.977898,40.784063]},\"categories\":[\"food-beverage\",\"restaurant\"]},{\"_id\":\"6492270442791a585df053f9\",\"name\":\"Morning Goods\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.97782,40.784143]},\"categories\":[\"food-beverage\",\"restaurant\"]},{\"_id\":\"62cd9339b259a660ba80aa12\",\"name\":\"King Food Restaurant\",\"location\":{\"type\":\"Point\",\"coordinates\":[-73.977893,40.784077]},\"categories\":[\"food-beverage\",\"restaurant\"]}]}")
