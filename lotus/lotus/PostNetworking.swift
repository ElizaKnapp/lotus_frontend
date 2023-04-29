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
    let tags: [Tag]
}

struct Tag: Hashable, Codable {
    let id: Int?
    let tag: String
}


class PostNetworking: ObservableObject {
    @Published var posts: [Post] = [] // view will update itself
    
    func fetch() {
        guard let url = URL(string: "http://localhost:5000/post") else {
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
    
    func post(title: String, author: String, time: String, group: String, content: String) {
        guard let url = URL(string: "http://localhost:5000/post") else {
            return
        }
        
        let parameters: [String: Any] = [
            "title": title,
            "author": author,
            "time": time,
            "group": group,
            "content": content,
            "tags": []
        ]
        
        print(parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
          // convert parameters to Data and assign dictionary to httpBody of request

            var test = try JSONSerialization.data(withJSONObject: parameters)

            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            
        } catch let error {
          print(error.localizedDescription)
          return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self]data, _,
            error in
            guard let data = data, error == nil
            else {
                return
            }
//
            // Convert to JSON
            do {

                let posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    print(posts)
                }
            }
            catch {
                print("problem here?")
                print(error)
            }
            
        }
        task.resume()
    }
    
    
    
    
}
