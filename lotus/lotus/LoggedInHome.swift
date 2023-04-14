//
//  LoggedInHome.swift
//  lotus
//
//  Created by Eliza Knapp on 3/13/23.
//

import Foundation
import SwiftUI
import UIKit

struct LoggedInHome: View {
    @State private var create_profile = false    
    
    var body: some View {
        if (create_profile) {
            CreateProfile()
        } else {
            ZStack{
                VStack{
                    Text("Welcome Page and User Agreement")
                    Button(action:{
                        create_profile = true
                        
                    }) {
                        Text("Create a profile")
                    }
//                    ForEach(network.users) {user in
//                        Text(user.username)
//                    }

                }
            }
        }
        
        
    }
}
