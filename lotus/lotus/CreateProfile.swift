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
    @State private var birthday = Date.now
    @State private var gender: String = ""
    @State private var profile_visibility: Bool = false
    
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
                        DatePicker(selection: $birthday, in: ...Date.now, displayedComponents: .date) {
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
