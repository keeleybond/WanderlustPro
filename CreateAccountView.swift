//
//  CreateAccountView.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 10/25/23.
//

import SwiftUI
struct CreateAccountView: View{
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View{
        VStack{
            Text("Wanderlust Pro")
                .font(.largeTitle)
            Spacer()
            Text("Create an Account Today!")
                .font(.title)
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
                Text("* password must be atleast 8 characters *")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Email", text:$email)
                    .padding(4)
                    .background(Color.mint)
                    .cornerRadius(6)
                Spacer()
                    .frame(height:40)
                Button("Create Account", action:createAccountPress)
                    .disabled(userName.isEmpty || password.count < 8 || email.isEmpty)

            }
            .padding(5)
            .background(Color.white)
            Spacer()
        }
    }
    
    func createAccountPress(){
        let user = CDUser(context: context)
        user.username = userName
        user.password = password
        user.email = email
        user.trips = []
        do {
            try context.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
