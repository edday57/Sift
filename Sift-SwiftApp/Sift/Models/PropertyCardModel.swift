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
    @Published var agent: User?
    init(property: Property, currentUser: User){
        self.property = property
        self.currentUser = currentUser
        self.fetchUser(userId: property.agent)
    }
    
    func fetchUser(userId: String){
        let defaults = UserDefaults.standard
        WebService().fetchUser(id: userId) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.agent = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}