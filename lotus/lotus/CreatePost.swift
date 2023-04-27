//
//  CreatePost.swift
//  lotus
//
//  Created by Eliza Knapp on 4/27/23.
//

import SwiftUI

struct CreatePost: View {
    @State private var title: String = ""
    @State private var content: String = ""
    @State var author: String
    @State var group: String
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Write a post! WOOT")
                Form {
                    TextField(text: $title, prompt: Text("Title")) {
                        Text("Title")
                    }
                    TextField(text: $content, prompt: Text("Content")) {
                        Text("Content")
                    }
                    Button(action: {
                        // push the post to the database
                    }) {
                        Text("Post!")
                    }
                }
            }
            
        }
    }
}
