//
//  HomePage.swift
//  lotus
//
//  Created by Eliza Knapp on 3/12/23.
//

import Foundation
import SwiftUI
import UIKit

struct HomePage: View {
    // whether the user is logged in- starts out false
    @State public var logged_in: Bool = false
    
    // stuff to save to the home once the login stuff happens
    @State public var username: String = ""
    @State public var email: String = ""


    var body: some View {
        NavigationView {
            if (!logged_in){
                ZStack {
                    Color("myPink").ignoresSafeArea()
                    VStack { // allows stackign stuff vertically top to bottom
                        Text("Lotus")
                            .font(.system(size: 50))
                            .foregroundColor(.black)
                        Image("lotus")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .foregroundColor(.accentColor)
                        Text("Let's talk infertility.")
                            .font(.system(size:50, weight: .semibold))
                            .foregroundColor(.white)
                        NavigationLink(destination: CreateAccount(username: $username, email: $email, logged_in: $logged_in)){
                            Text("Join Now")
                                .padding()
                                .font(.system(size: 40))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                        NavigationLink(destination: LoginPage(username: $username, email: $email, logged_in: $logged_in)){
                            Text("Log In")
                                .padding()
                                .font(.system(size: 40))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                        
                    }
                    .padding()
                }
            } else {
                ZStack {
                    Color("myPink").ignoresSafeArea()
                    VStack {
                        Text("Hi \(username)")
                        Text("Welcome Page and User Agreement")
//                        NavigationLink(destination: CreateProfile(username: $username)){
//                            Text("Profile")
//                                .padding()
//                                .font(.system(size: 40))
//                                .background(.white)
//                                .foregroundColor(.black)
//                        }
                        Button(action: {
                            logged_in = false
                            username = ""
                            email = ""
                        }) {
                            Text("Log Out")
                                .padding()
                                .font(.system(size: 40))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                    }
                }
                
                
            }
        }
        

    }
}
