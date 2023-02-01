//
//  UserViewModel.swift
//  Sift
//
//  Created by Edward Day on 27/01/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    var userLoaded: Bool = false
    
    init(userid: String?, user: User?){
        if user != nil{
            self.user = user
            userLoaded = true
        }
        else if userid != nil{
            fetchUser(userId: userid!)
        }

    }
    
    func fetchUser(userId: String){
        WebService().fetchUser(id: userId) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                    self.userLoaded = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
