//
//  Data.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import Foundation
import SwiftUI


var propertyData: [Property] = [
    Property(address: "23 Parsons Green", postcode: "SW5 3HF", price: 4500, bedrooms: 3, locX: 23, locY: 12, image: "placeholderProperty1", id: 1),
    Property(address: "114 Ivy Grove", postcode: "SW7 1NB", price: 3700, bedrooms: 3, locX: 2, locY: 1, image: "placeholderProperty2", id: 1),
    Property(address: "210b Deansgate Tower North", postcode: "MC1 9DR", price: 2100, bedrooms: 2, locX: 97, locY: 52, image: "placeholderProperty3", id: 1)
]

var userData: [User] = [
    User(id: 1, landlord: true, firstName: "Andrew", lastName: "Tate", profilePic: "Tate", dob: "04-12-1990")
]
