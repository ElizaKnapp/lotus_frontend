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
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var email: String = ""
    
    @State private var message: String = "" // error message about whether the user creation was succeessful
    
    @State public var login = true // whether the login site is shown (vs home)
    @State public var loggedIn = false // whether the user is logged in (if logged in, move to the logged in home page)
    
    @StateObject var userNetworking = UserNetworking()
    
    @StateObject var db = DBChecker()
    
    var body: some View {
        if (loggedIn) {
            // TODO: SOMEHOW STORE THE INFO IN THE DB AND PASS IT TO LOGGED IN HOME
            LoggedInHome()
            
        } else if (login){
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
                                loggedIn = true
                            } else {
                                print(message)
                            }
                        }) {
                            Text("Submit")
                        }
                    }
                
                    Button(action: {
                        print("button tapped")
                        login = false // gets you back to home
                    }) {
                        Text("Back To Home")
                            .padding()
                            .font(.system(size: 40))
                            .background(.white)
                            .foregroundColor(.black)
                    }
                }
                .onAppear {
                    userNetworking.fetch()
                    

                }

            }
        } else {
            HomePage()
        }

    }
    
    
}
