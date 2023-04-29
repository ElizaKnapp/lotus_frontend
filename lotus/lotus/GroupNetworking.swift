//
//  Group.swift
//  lotus
//
//  Created by Eliza Knapp on 4/13/23.
//

// this file contains all the posts to the express api

import Foundation

import SwiftUI

struct Group: Hashable, Codable {
    let id: Int?
    let name: String
    let about: String
    let num_members: Int
    let tags: [Tag1]
    let posts: [String]
    let time: String
}

struct Tag1: Hashable, Codable {
    let id: Int?
    let tag: String
}

struct Post1: Hashable, Codable {
    let id: Int?
    let title: String
}



class GroupNetworking: ObservableObject {
    @Published var groups: [Group] = [] // view will update itself
    
    func fetch() {
        guard let url = URL(string: "http://localhost:5000/group") else {
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
                let groups = try JSONDecoder().decode([Group].self, from: data)
                DispatchQueue.main.async {
                    self?.groups = groups
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func fetch_one(name: String) {
        let url_string = "http://localhost:5000/group/byName/" + name
        
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
                let groups = try JSONDecoder().decode([Group].self, from: data)
                DispatchQueue.main.async {
                    self?.groups = groups
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func patch(name: String, num_members: Int) {
        let url_string = "http://localhost:5000/group/byName/" + name

        guard let url = URL(string: url_string) else {
            return
        }
                
        let parameters: [String: Any] = [
            "num_members": num_members
        ]
        print(parameters)
        print (type(of: parameters))
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
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

                let groups = try JSONDecoder().decode([Group].self, from: data)
                DispatchQueue.main.async {
                    print(groups)
                    self?.groups = groups
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    
}
