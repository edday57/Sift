//
//  Model.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import Foundation
import SwiftUI

struct Property: Identifiable {
    var address: String
    var postcode: String
    var price: Float
    var bedrooms: Int
    var locX: Float?
    var locY: Float?
    var image: String
    var id: Int
}

struct Property_FB: Identifiable {
    var address1: String
    var address2: String
    var postcode: String
    var price: Float
    var bedrooms: Int
    var bathrooms: Int
    var locX: Float?
    var locY: Float?
    var image: String
    var id: String
}

struct User {
    var id: Int
    var landlord: Bool
    var firstName: String
    var lastName: String
    var profilePic: String?
    var dob: String
    var bio: String?
}


