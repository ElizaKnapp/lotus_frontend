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
    
    // which tab of the home page we're on
    @State public var tab: Int = 0 // 0 1 or 2
    
    
    // for the groups shown
    @StateObject var groupNetworking = GroupNetworking()
    @StateObject var userInfoNetworking = UserInfoNetworking()
    @StateObject var postNetworking = PostNetworking()
    
    @State public var myGroups: [Group] = []
    @State public var myPosts: [Post] = []
        
    
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
                    Color("lightPink").ignoresSafeArea()
                    VStack {
                        if (tab == 0) {
                            HStack {
                                Text("Groups")
                                    .padding().font(.system(size: 20)).background(Color("darkPink")).foregroundColor(.white)
                                Button(action: {
                                    tab = 1
                                }) {
                                    Text("My Feed")
                                        .padding().font(.system(size: 20)).background(Color("myPink")).foregroundColor(.white)
                                }
                                Button(action: {
                                    tab = 2
                                }) {
                                    Text("My Groups")
                                        .padding() .font(.system(size: 20)).background(Color("myPink")).foregroundColor(.white)
                                }
                            }
                            Text("Hi \(username)")
                            Text("My Groups Page")
                            List {
                                ForEach(groupNetworking.groups, id: \.self) {group in
                                    HStack {
                                        VStack {
                                            Text(group.name)
                                            Text("Members: " + group.num_members.codingKey.stringValue)
                                        }
                                        NavigationLink(destination: GroupInfo(username: username, group_name: group.name, info: group.about, num_members: group.num_members, joined: false, groups: groups)){
                                            Text("More Info")
                                        }
                                    }
                                    
                                }
                            }
                            
                    
                        }
                        else if (tab == 1) {
                            HStack {
                                Button(action: {
                                    tab = 0
                                }) {
                                    Text("Groups")
                                        .padding().font(.system(size: 20)).background(Color("myPink")).foregroundColor(.white)
                                }
                                Text("My Feed")
                                    .padding().font(.system(size: 20)).background(Color("darkPink")).foregroundColor(.white)
                                
                                Button(action: {
                                    tab = 2
                                }) {
                                    Text("My Groups")
                                        .padding() .font(.system(size: 20)).background(Color("myPink")).foregroundColor(.white)
                                }
                            }
                            Text("Hi \(username)")
                            Text("My Feed Page- below should be posts from the groups that you're in")
                            Text("Still working on it!")

                            List {
                                ForEach(myPosts, id: \.self) {post in
                                    // myPosts is an array of posts of the groups that you are in
                                    HStack {
                                        HStack {
                                            VStack {
                                                Text(post.author)
                                                Text(post.title)
                                                Text(post.content)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            HStack {
                                Button(action: {
                                    tab = 0
                                }) {
                                    Text("Groups")
                                        .padding().font(.system(size: 20)).background(Color("myPink")).foregroundColor(.white)
                                }
                                Button(action: {
                                    tab = 1
                                }) {
                                    Text("My Feed")
                                        .padding() .font(.system(size: 20)).background(Color("myPink")).foregroundColor(.white)
                                }
                                Text("My Groups")
                                    .padding().font(.system(size: 20)).background(Color("darkPink")).foregroundColor(.white)
                                
                               
                            }
                            
                            Text("Hi \(username)")
                            Text("My Groups Page- below should be groups that you're in")
                            
                            List {
                                ForEach(myGroups, id: \.self) {group in
                                    HStack {
                                        HStack {
                                            VStack {
                                                Text(group.name)
                                                Text("Members: " + group.num_members.codingKey.stringValue)
                                            }
                                            NavigationLink(destination: GroupInfo(username: username, group_name: group.name, info: group.about, num_members: group.num_members, joined: true, groups: groups)){
                                                Text("Open Group")
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
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
                        
                        if (groupNetworking.loaded_groups) {
                            Text("Loaded Groups").onAppear{
                                
                            }
                        }
                    }
                        
                    
                
                }.onAppear{
                    // fetch the groups and also the groups that the person is a part of
                    
                    // flag MAKE SURE IT ONLY RUNS ONCE
                    Task {
                        try await groupNetworking.fetch()
                        await userInfoNetworking.fetch_one(username: username)
                        await postNetworking.fetch()

                        groups = []
                        if (userInfoNetworking.userInfos != []) {
                            for item in userInfoNetworking.userInfos[0].groups {
                                groups.append(item.name)
                            }
                        }
                        
                        myGroups = []
                        // here make the array of ones
                        for group in groupNetworking.groups {
                            if (groups.contains(group.name)) {
                                myGroups.append(group)
                            }
                        }
                        
                        myPosts = []
                        for post in postNetworking.posts {
                            if (groups.contains(post.group)) {
                                myPosts.append(post)
                            }
                        }
                        
                    }

                    
                    
                    // print(userInfoNetworking.userInfos)
                    // query the db for list of groups
                                      
                    // print(groups)
                
                    // print(myGroups)
                    
                    // finally, per item in groups, query posts

                    
                    // groupNetworking.finish_fetching = true
                
                    // print(myPosts)
                    
                }
      
            }
        }

    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
