//
//  UserModel.swift
//  Sift
//
//  Created by Edward Day on 12/01/2023.
//

import Foundation

struct User: Codable{
    let email: String?
    let signedUp: Bool?
    let name: String?
    let about: String?
    let image: String?
    let dob: String?
    var token: String?
}
