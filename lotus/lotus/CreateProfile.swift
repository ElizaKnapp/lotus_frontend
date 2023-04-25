//
//  CreateProfile.swift
//  lotus
//
//  Created by Eliza Knapp on 3/13/23.
//

import Foundation
import SwiftUI
import UIKit

import Alamofire

struct CreateProfile: View {
    @State private var first_name: String = ""
    @State private var last_name: String = ""
    @State private var birthday: Date = Date.now
    @State private var string_birthday: String = ""
    @State private var gender: String = "Female"
    @State private var profile_visibility: String = "Yes"
    @Binding var username: String
    @Binding var logged_in: Bool
    @State private var user_agreement: Bool = false
    
    var prof_ops = ["Yes", "No"]
    var gender_ops = ["Female", "Male", "Non-Binary", "Other", "Prefer no to say"]
    
    // networking to add users and their info to the db
    @StateObject var userInfoNetworking = UserInfoNetworking()
    
    var body: some View {
            ZStack{
                if (!user_agreement) {
                    VStack{
                        Text("Create a profile!")
                        Form {
                            TextField(text: $first_name, prompt: Text("First Name")) {
                                Text("First Name")
                            }
                            TextField(text: $last_name, prompt: Text("Last Name")) {
                                Text("Last Name")
                            }
                            DatePicker(selection: $birthday, displayedComponents: .date) {
                                            Text("Birthday")
                            }
                            Picker("Gender", selection: $gender) {
                                ForEach(gender_ops, id: \.self) {
                                                    Text($0)
                                                }
                            }
                            Picker("Would you like your user information to be shown?", selection: $profile_visibility) {
                                ForEach(prof_ops, id: \.self) {
                                                    Text($0)
                                                }
                            }
                            Button(action : {
                                // push the data to the database
                                
                                // to format date and push to db
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd.MM.yyyy"
                                
                                
                                
                                string_birthday = dateFormatter.string(from: birthday)
                                
            
       
                                // issue right now: not saving gender or profile visibility
                                userInfoNetworking.post(username: username, first_name: first_name, last_name: last_name, birthday: string_birthday, gender: gender, profile_visibility: profile_visibility)

                                
                                //should go to the main page/groups
                                user_agreement = true
                                
                                
                                
                                
                            }){
                                Text("Save Data")
                            }


                        }
                    
                    }
                    
                } else {
                    VStack {
                        Text("user agreement this is very important!")
                        Button(action:{
                            logged_in = true

                        }) {
                            Text("Agree")
                        }
                    }
                    
                }
                



            }




        
    }
}


// NEXT
// STEPS- FIGURE OUT THIS PAGE FOR REAL!
