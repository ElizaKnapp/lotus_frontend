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
    @State public var home = true
    @State public var login = false
    @State public var createAccount = false
    
    var body: some View {
        if (home){
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
                    Button(action: {
                        print("button tapped")
                        home = false
                        createAccount = true
                    }) {
                        Text("Join Now")
                            .padding()
                            .font(.system(size: 40))
                            .background(.white)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        home = false
                        login = true
                    }) {
                        Text("Login In")
                            .padding()
                            .font(.system(size: 40))
                            .background(.white)
                            .foregroundColor(.black)
                    }
                    
                }
                .padding()
            }
        } else {
            if (login) {
                LoginPage()
            }
            else if (createAccount) {
                CreateAccount()
            }
        }

    }
}
