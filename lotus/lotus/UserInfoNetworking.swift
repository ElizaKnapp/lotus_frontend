//
//  UserNetworking.swift
//  lotus
//
//  Created by Eliza Knapp on 4/13/23.
//

// this file contains all the posts to the express api

import Foundation

import SwiftUI

import Foundation
extension Dictionary {
       
   var jsonData: Data? {
      return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
   }
       
   func toJSONString() -> String? {
      if let jsonData = jsonData {
         let jsonString = String(data: jsonData, encoding: .utf8)
         return jsonString
      }
      return nil
   }
}

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
    @Published var userInfos: [UserInfo] = [] // view will update itself
    
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
                let userInfos = try JSONDecoder().decode([UserInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.userInfos = userInfos
                    print(userInfos)
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
                let userInfos = try JSONDecoder().decode([UserInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.userInfos = userInfos
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
            "profile_visibility": profile_visibility,
            "groups": []
        ]
        print(parameters)
        print (type(of: parameters))
        
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

                let userInfos = try JSONDecoder().decode([UserInfo].self, from: data)
                DispatchQueue.main.async {
                    print(userInfos)
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func put(username: String, group_name: String) {
        let url_string = "http://localhost:5000/userInfo/byUsername/" + username

        guard let url = URL(string: url_string) else {
            return
        }
                
        let parameters: [String: Any] = [
            "groups": [
                  "name": "endometriosis"
              ]
        ]
        print(parameters)
        print (type(of: parameters))
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
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

                let userInfos = try JSONDecoder().decode([UserInfo].self, from: data)
                DispatchQueue.main.async {
                    print(userInfos)
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
}
