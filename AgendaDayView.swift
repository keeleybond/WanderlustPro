//
//  AgendaDayView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/10/23.
//

import SwiftUI

struct AgendaDayView: View {
    
    let agendaItems: [CDAgendaItem]
        
    var body: some View {
        VStack {
            if agendaItems.count == 0 {
                Text("No plans yet").frame(maxWidth: .infinity)
            } else {
                ForEach(agendaItems) { item in
                    HStack{
                        Image(systemName: AgendaItemType(rawValue: item.agendaItemType!)!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16 , height: 16)
                        Text(item.name!)
                    }
                }
            }
        }
    }
}
