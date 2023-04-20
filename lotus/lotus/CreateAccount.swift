//
//  LoginPage.swift
//  lotus
//
//  Created by Eliza Knapp on 3/12/23.
//

import Foundation
import SwiftUI
import UIKit

struct CreateAccount: View {
    
    @Binding var username: String
    @State private var password: String = ""
    @State private var password2: String = ""
    @Binding var email: String
    
    @State private var message: String = "" // error message about whether the user creation was succeessful
    
    @Binding var logged_in: Bool // whether the user is logged in (if logged in, move to the logged in home page)
    
    @State private var done: Bool = false
    
    @StateObject var userNetworking = UserNetworking()
    
    @StateObject var db = DBChecker()
    
    var body: some View {
        if (done) {
            CreateProfile(username: $username, logged_in: $logged_in)
            
        } else {
            ZStack{
                VStack{
                    // below will be my attempt at a form
                    Text(message)
                    Form {
                        TextField(text: $username, prompt: Text("Username")) {
                            Text("Username")
                        }
                        TextField(text: $email, prompt: Text("Email")) {
                            Text("Email")
                        }
                        Text("Please input a password with length greater than 8 characters")
                        SecureField(text: $password, prompt: Text("Password")) {
                            Text("Password")
                        }
                        SecureField(text: $password2, prompt: Text("Confirm Password")) {
                            Text("Confirm Password")
                        }
                        // allow submission by clicking the button
                        Button(action:{
                            message = db.validateUser(username: username, password: password, password2: password2, email: email, existing_users: userNetworking.users)
                            
                            if (message == "") {
                                userNetworking.post(username: username, password: password, email: email)
                                done = true
                            } else {
                                print(message)
                            }
                        }) {
                            Text("Submit")
                        }
                    }

                }
                .onAppear {
                    userNetworking.fetch()
                    

                }

            }
        }

    }
    
    
}
