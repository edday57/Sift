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
    var isAgent: Bool
    var name: String
    var mobile: String?
    var about: String?
    var image: String?
    var dob: String?
    var token: String?
    var salary: Int?
    var renterType: String?
    var profession: String?
}

var userDemo: User = User(_id: "", email: "joe@apple.com", isAgent: false, name: "Jenny Phillips", about: "Post-Grad Student | London")
var agentDemo: User = User(_id: "", email: "agent@apple.com", isAgent: true, name: "Chestertons Lettings", image: "https://upload.wikimedia.org/wikipedia/commons/c/cc/Chestertons_purple_logo.png")
