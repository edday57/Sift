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
    init(property: Property, currentUser: User, agent: User? = nil){
        self.property = property
        self.agent = agent
        self.currentUser = currentUser
        self.fetchUser(userId: property.agent)
    }
    
    func fetchUser(userId: String){
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
    func addLike(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        WebService().addLike(user: currentUser.id, listing: property.id, token: token) { response in
            if response == 200{
                DispatchQueue.main.async {
                    print("Like added")
                }
                
            }
        }
    }
}
