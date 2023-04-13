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
    
    var body: some View {
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
                        }
                    }
                }
        }
        
    }
}


// NEXT
// STEPS- FIGURE OUT THIS PAGE FOR REAL!
