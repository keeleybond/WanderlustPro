//
//  HomePageView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/25/23.
//

import SwiftUI

struct HomePageView: View {
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var appState: AppState
    
    @State var isShowingSignIn = true
    
    var body: some View {
        NavigationView {
            GeometryReader{ geo in
                VStack{
                    Image("welcomeImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width - 60, height: geo.size.width - 60)
                        .clipped()
                        .padding(.top,20)
                    Spacer()
                        .frame(height: 30)
                    VStack(spacing:4){
                        NavigationLink {
                            PlanATripView()
                        } label: {
                            HStack{
                                Text("Plan a new trip")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                            }
                            .frame(height:60)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                        }
                        NavigationLink {
                            UpcomingTripsView()
                        } label: {
                            HStack{
                                Text("Upcoming trips")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                            }
                            .frame(height:60)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                        }
                    }
                    .padding(.horizontal,10)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.gray,for:.navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .fullScreenCover(isPresented: $isShowingSignIn) {
                SignInView(didSignInHandler: signInHandler)
                    .environment(\.managedObjectContext, context)
                    .environmentObject(appState)
            }
        }
    }
    func signInHandler(){
        isShowingSignIn = false
    }
}

