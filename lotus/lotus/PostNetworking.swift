//
//  Post.swift
//  lotus
//
//  Created by Eliza Knapp on 4/13/23.
//

// this file contains all the posts to the express api

import Foundation

import SwiftUI

struct Post: Hashable, Codable {
    let id: Int?
    let title: String
    let author: String
    let time: String
    let group: String
    let content: String
    let tags: [String]
}


class PostNetworking: ObservableObject {
    @Published var posts: [Post] = [] // view will update itself
    
    func fetch_one(group: String) {
        let url_string = "http://localhost:5000/post/byGroup/" + group
        
        guard let url = URL(string: url_string) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self]data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self?.posts = posts
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    
}
