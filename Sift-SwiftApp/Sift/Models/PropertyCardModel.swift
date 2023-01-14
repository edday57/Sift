//
//  PropertyCardModel.swift
//  Sift
//
//  Created by Edward Day on 14/01/2023.
//

import Foundation

class PropertyCardModel: ObservableObject {
    @Published var property: Property
    let currentUser: User
    
    init(property: Property, currentUser: User){
        self.property = property
        self.currentUser = currentUser
    }
}
