//
//  UserInfoNetworking.swift
//  lotus
//
//  Created by Eliza Knapp on 4/18/23.
//

// this file contains all the posts to the express api

import Foundation

import SwiftUI

struct UserInfo: Hashable, Codable {
    let id: Int?
    let username: String
    let first_name: String
    let last_name: String
    let birthday: String
    let gender: String
    let profile_visibility: String
}


class UserInfoNetworking: ObservableObject {
    @Published var users: [UserInfo] = [] // view will update itself
    
    func fetch() {
        guard let url = URL(string: "http://localhost:5000/userInfo") else {
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
                let users = try JSONDecoder().decode([UserInfo].self, from: data)
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
        let url_string = "http://localhost:5000/userInfo/byUsername/" + username
        
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
                let users = try JSONDecoder().decode([UserInfo].self, from: data)
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
    
    func post(username: String, first_name: String, last_name: String, birthday: String, gender: String, profile_visibility: String) {
        guard let url = URL(string: "http://localhost:5000/userInfo") else {
            return
        }
        
        let parameters: [String: Any] = [
            "username": username,
            "first_name": first_name,
            "last_name": last_name,
            "birthday": birthday,
            "gender": gender,
            "profile_visibility": profile_visibility
        ]
        
        // PARAMETERS WORK
        print(parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
          // convert parameters to Data and assign dictionary to httpBody of request
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("error below")
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
                // error is in the line below
                let users = try JSONDecoder().decode(UserInfo.self, from: data)
                DispatchQueue.main.async {
                    print(users)
                    print("^^ users")
                }
                
            }
            catch {
                print("hello")
                print(error)
            }
            
        }
        task.resume()
    }
    
}