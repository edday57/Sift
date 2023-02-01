//
//  UserModel.swift
//  Sift
//
//  Created by Edward Day on 12/01/2023.
//

import Foundation

struct User: Codable, Identifiable{
    var id: String {
        return _id
    }
    var _id: String
    var email: String
    var signedUp: Bool
    var isAgent: Bool
    var name: String?
    var about: String?
    var image: String?
    var dob: String?
    var token: String?
    
}

var userDemo: User = User(_id: "", email: "joe@apple.com", signedUp: true, isAgent: false, name: "Jenny Phillips", about: "Post-Grad Student | London")
