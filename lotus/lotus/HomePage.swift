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
                    }) {
                        Text("Join Now")
                            .padding()
                            .font(.system(size: 40))
                            .background(.white)
                            .foregroundColor(.black)
                    }
                    
                }
                .padding()
            }
        } else {
            LoginPage()
        }

    }
}
