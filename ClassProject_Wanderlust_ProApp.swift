//
//  ClassProject_Wanderlust_ProApp.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/17/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var user: CDUser?
}


@main
struct ClassProject_Wanderlust_ProApp: App {

    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environment(\.managedObjectContext, PersistentController.shared.container.viewContext)
                .environmentObject(appState)
        }
    }
}
