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
    let tags: [String]
    let posts: [String]
    let time: String
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
    
    
}
