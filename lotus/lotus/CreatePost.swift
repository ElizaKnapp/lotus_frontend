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
    @State var string_time: String = ""
    
    @StateObject var postNetworking = PostNetworking()

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

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
                    
                }
                .navigationBarItems(leading: Button(action : {
                    // push the data to the database
                    
                    // push the post to the database
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
          
                    string_time = dateFormatter.string(from: Date.now)
                    
                    // HERE DO THE DB CHECKER- make sure they have a title and content
                    
                    postNetworking.post(title: title, author: author, time: string_time, group: group, content: content)
                    print("posted")
                    
                    self.mode.wrappedValue.dismiss()
                }){
                    Text("Submit Post")
                    
                })
            }
            
        }
        
        
    }
}
