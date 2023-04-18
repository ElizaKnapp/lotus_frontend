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
    
    @Binding var username: String
    @State private var password: String = ""
    @State private var password2: String = ""
    @Binding var email: String
    
    @State private var message: String = "" // error message about whether the user creation was succeessful
    
    @Binding var logged_in: Bool // whether the user is logged in (if logged in, move to the logged in home page)
    
    @StateObject var userNetworking = UserNetworking()
    
    // database
    @StateObject var db = DBChecker()
    
    var body: some View {
        if (logged_in) {
            HomePage()
            
        } else {
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
                                logged_in = true
                            } else {
                                message = "Please input a correct username and password"
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
