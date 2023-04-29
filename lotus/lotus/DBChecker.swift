//
//  DBChecker.swift
//  lotus
//
//  Created by Eliza Knapp on 4/13/23.
//


// this file contains all the things we check before we post stuff to the db
import Foundation

class DBChecker: ObservableObject {
    
    func validateUser(username: String, password: String, password2: String, email: String, existing_users: [User]) -> String {
        print(username)
        
        for user in existing_users {
            if (user.username == username) {
                return "that username has already been taken"
            }
            if (user.email == email) {
                return "that email has already been taken"
            }
        }
        
        if (username == "") {
            return "please enter a username"
        }
        else if (password != password2) {
            return "make sure passwords match"
        }
        else if (password.count < 8) {
            return "please adhere to the password guildlines"
        }
        else if (email == "") {
            return "please enter an email"
        }
        else {
            return ""
        }
        
    }
    
    func doesUserExist(username: String, password: String, users: [User]) -> Bool {
        for user in users {
            if (user.username == username && user.password == password) {
                return true
            }
        }
        return false
    }
    
    func validPost(title: String, content: String) -> Bool {
        // should this also make sure there aren't double titles?
        
        if (title != "" && content != "") {
            return true
        }
        return false
    }
    
    
}
