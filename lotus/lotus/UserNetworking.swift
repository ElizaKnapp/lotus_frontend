//
//  UserNetworking.swift
//  lotus
//
//  Created by Eliza Knapp on 4/13/23.
//

// this file contains all the posts to the express api

import Foundation

import SwiftUI

struct User: Hashable, Codable {
    let id: Int?
    let username: String
    let password: String
    let email: String
}


class UserNetworking: ObservableObject {
    @Published var users: [User] = [] // view will update itself
    
    func fetch() {
        guard let url = URL(string: "http://localhost:5000/user") else {
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
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.users = users
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func fetch_one(username: String) {
        let url_string = "http://localhost:5000/user/byUsername/" + username
        
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
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.users = users
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func post(username: String, password: String, email: String) {
        guard let url = URL(string: "http://localhost:5000/user") else {
            return
        }
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "email": email
        ]
        print(parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            print("******here********")
            var test = try JSONSerialization.data(withJSONObject: parameters)
            print(test)
            print(test.self)
            print(type(of: test))
            print(JSONSerialization.isValidJSONObject(test))
            
          // convert parameters to Data and assign dictionary to httpBody of request
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
            
            // Convert to JSON
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    print(users)
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
}
