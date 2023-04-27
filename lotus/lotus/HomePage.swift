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
    @State public var groups: [String] = []

    // for the groups shown
    @StateObject var groupNetworking = GroupNetworking()
    @StateObject var userInfoNetworking = UserInfoNetworking()

    
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
                        // THE FOLLOWING IS A TESTING BUTTON- REMOVE EVENTUALLY
//                        Button(action:{
//                            groupNetworking.patch(name: "endometriosis", num_members: 8)
//                        }) {
//                            Text("testing")
//                        }
                    }
                    .padding()
                }
            } else {
                
                ZStack {
                    Color("myPink").ignoresSafeArea()
                    VStack {
                        HStack {
                            Text("Groups")
                                .padding()
                                .font(.system(size: 20))
                                .background(.white)
                                .foregroundColor(.black)
                            // eventually the two texts below will be the myfeed and mygroups buttons
                            Text("My Feed")
                                .padding()
                                .font(.system(size: 20))
                                .background(.white)
                                .foregroundColor(.black)
                            Text("My Groups")
                                .padding()
                                .font(.system(size: 20))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                        Text("Hi \(username)")
                        Text("My Groups Page")
                        
                        // THE BELOW LINK will be to edit profile (LATER)
//                        NavigationLink(destination: CreateProfile(username: $username)){
//                            Text("Profile")
//                                .padding()
//                                .font(.system(size: 40))
//                                .background(.white)
//                                .foregroundColor(.black)
//                        }
                        List {
                            ForEach(groupNetworking.groups, id: \.self) {group in
                                HStack {
                                    VStack {
                                        Text(group.name)
                                        Text("Members: " + group.num_members.codingKey.stringValue)
                                    }
                                    // somehow also pass the array of the users groups or smth
                                    // FIGURE OUT IF THE USER HAS JOINED THE GROUP AND PASS THAT IN
                                    NavigationLink(destination: GroupInfo(username: username, group_name: group.name, info: group.about, num_members: group.num_members, joined: false, groups: groups)){
                                        Text("More Info")
                                    }
                                }
                                
                                
                            }
                        }.onAppear{
                            print(userInfoNetworking.userInfos)
                            // query the db for list of groups
                            userInfoNetworking.fetch_one(username: username)
                            
                            // BUG- THIS DOESN'T LOAD FAST ENOUGH??
                            groups = []
                            if (userInfoNetworking.userInfos != []) {
                                for item in userInfoNetworking.userInfos[0].groups {
                                    groups.append(item.name)
                                }
                            }
                            
                            print(groups)
                        }

                        Button(action: {
                            logged_in = false
                            username = ""
                            email = ""
                            groups = []
                        }) {
                            Text("Log Out")
                                .padding()
                                .font(.system(size: 20))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                    }
                }.onAppear{
                    groupNetworking.fetch()
                }
                
                
            }
        }
        

    }
}
