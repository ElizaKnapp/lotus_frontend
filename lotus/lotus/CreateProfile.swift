//
//  CreateProfile.swift
//  lotus
//
//  Created by Eliza Knapp on 3/13/23.
//

import Foundation
import SwiftUI
import UIKit

struct CreateProfile: View {
    @State private var first_name: String = ""
    @State private var last_name: String = ""
    @State private var birthday: Date = Date.now
    @State private var string_birthday: String = ""
    @State private var gender: String = ""
    @State private var profile_visibility: String = ""
    @Binding var username: String
    
    // networking to add users and their info to the db
    @StateObject var userInfoNetworking = UserInfoNetworking()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ZStack{
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
                            Text("Female")
                            Text("Male")
                            Text("Non-binary")
                            Text("Other")
                            Text("Prefer not to say")
                        }
                        Picker("Would you like your user information to be shown?", selection: $profile_visibility) {
                            Text("Yes")
                                
                            Text("No")
                        }
                        .navigationBarItems(leading: Button(action : {
                            // push the data to the database
                            
                            // to format date and push to db
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd.MM.yyyy"
                            
                            
                            string_birthday = dateFormatter.string(from: birthday)
                            
                            print(username)
                            
                            userInfoNetworking.post(username: username, first_name: first_name, last_name: last_name, birthday: string_birthday, gender: gender, profile_visibility: profile_visibility)
                            
                            
                            //should go to the main page/groups
                            
                            
                            
                            
                            
                            self.mode.wrappedValue.dismiss()
                        }){
                            Text("Save Data")
                        })

                    }
                
                }


            }

        }


        
    }
}


// NEXT
// STEPS- FIGURE OUT THIS PAGE FOR REAL!
