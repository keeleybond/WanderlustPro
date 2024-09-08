//
//  SignInView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/17/23.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var appState: AppState
    
    @FetchRequest(fetchRequest: CDUser.fetchAll()) var users
    
    let didSignInHandler: () -> Void
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30){
                ZStack{
                    Image("travel")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Text("Where adventure begins!")
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                LoginView(signInHandler: signInHandler(userName:password:))
                
            }
            .padding()
            .navigationTitle("Wanderlust Pro")
            .toolbar{
                ToolbarItem {
                    NavigationLink("Create Account") {
                        CreateAccountView()
                    }
                }
            }
            .interactiveDismissDisabled(true)
            .toolbarBackground(Color.mint,for:.navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    func signInHandler(userName:String, password:String){
        let user = users.first { user in
            user.username?.lowercased() == userName.lowercased() &&
            user.password == password
        }
        
        if let user {
            appState.user = user
            didSignInHandler()
        } else {
            print("User not found")
            print("\tUsername: \(userName)")
            print("\tPassword: \(password)")
            
            print("\tUsers")
            users.forEach { print("\t\tusername: \($0.username!), password: \($0.password!)")}
            
        }
    }
}


