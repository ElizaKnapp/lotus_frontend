//
//  GroupInfo.swift
//  lotus
//
//  Created by Eliza Knapp on 4/22/23.
//

import SwiftUI

struct GroupInfo: View {
    
    // use the database to get posts to show- search posts by group: group.name
    
    @State var group_name: String
    @State var info: String
    @State var num_members: Int
    
    // state var to decide whether the person is in the group to decide which button to show

    
    var body: some View {
        ZStack {
            VStack{
                Text(group_name)
                Text(String(num_members) + " Active Members")
                Button(action: {
                    // whatever join group does here
                    
                    // if you are joined then show the post button
                }) {
                    Text("Join Group")
                }
                
                Text("About this group: " + info)
            }
        }
    }
}
