//
//  GroupInfo.swift
//  lotus
//
//  Created by Eliza Knapp on 4/22/23.
//

import SwiftUI

struct GroupInfo: View {

    @State var username: String

    
    @State var group_name: String
    @State var info: String
    @State var num_members: Int
        
    // state var to decide whether the person is in the group to decide which button to show
    @State var joined: Bool // pass in whether the group is joined (discovered on HomePage)
    
    // networking
    @StateObject var postNetworking = PostNetworking()
    @StateObject var userInfoNetworking = UserInfoNetworking()
    @StateObject var groupNetworking = GroupNetworking()

    var body: some View {
        ZStack {
            VStack{
                Text(group_name)
                Text(String(num_members) + " Active Members")
                if (!joined) {
                    Button(action: {
                        
                        // add to the user's groups joined in the database
                        userInfoNetworking.put(username: "Eliza", group_name: group_name)
                        
                        // add to the number of members in a group
                        
                        // change
                        joined = true
                        
                        // if you are joined then show the post button
                    }) {
                        Text("Join Group")
                    }
                } else {
                    Button(action: {
                        // do whatever for post (probably a new scheme
                    }) {
                        Text("Create Post")
                    }
                }
                
                
                Text("About this group: " + info)
                
                if (joined) {
                    Button(action: {
                        // leave group
                        joined = false
                    }) {
                        Text("Leave Group")
                    }
                }
                
                List {
                    ForEach(postNetworking.posts, id: \.self) {post in
                        VStack {
                            Text(post.author)
                            Text(post.title)
                            Text(post.content)
                        }
                    
                        
                        
                    }
                }
            }
        }.onAppear{
            // fetch the posts
            postNetworking.fetch_one(group: group_name)
        }
    }
}
