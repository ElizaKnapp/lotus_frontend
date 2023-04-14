//
//  LoginPage.swift
//  lotus
//
//  Created by Eliza Knapp on 3/12/23.
//

import Foundation
import SwiftUI
import UIKit

struct LoginPage: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var email: String = ""
    
    @State private var message: String = "" // error message about whether the user creation was succeessful
    
    @State public var login = true // whether the login site is shown (vs home)
    @State public var loggedIn = false // whether the user is logged in (if logged in, move to the logged in home page)
    
    @StateObject var userNetworking = UserNetworking()
    
    // database
    @StateObject var db = DBChecker()
    
    var body: some View {
        if (loggedIn) {
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
                        SecureField(text: $password, prompt: Text("Password")) {
                            Text("Password")
                        }
                        // allow submission by clicking the button
                        Button(action:{
                            // THESE BELOW ACTIONS SHOULD BE DIF
                            // check if username and password match
                            userNetworking.fetch_one(username: username)
                            if (db.doesUserExist(username: username, password: password, users: userNetworking.users)) {
                                loggedIn = true
                            } else {
                                message = "Please input a correct username and password"
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
