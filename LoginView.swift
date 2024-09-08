//
//  LoginView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/21/23.
//

import SwiftUI

struct LoginView:View{
    @State private var userName = ""
    @State private var password = ""
    let signInHandler:(String,String) -> Void

    var body: some View{
        VStack{
            Text("Sign in")
                .font(.title2)
            VStack{
                TextField("Username", text:$userName)
                    .padding(4)
                    .background(Color.mint)
                    .cornerRadius(6)
                SecureField("Password", text:$password)
                    .padding(4)
                    .padding(.horizontal,4)
                    .background(Color.mint)
                    .cornerRadius(6)
                Spacer()
                    .frame(height:40)
                Button("Sign in", action:{signInHandler(userName,password)})
                    .disabled(userName.isEmpty || password.isEmpty)

            }
            .padding(5)
        }
    }
    
}

