//
//  LoginViewModel.swift
//  Articulate
//
//  Created by Edward Day on 01/12/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    init() {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        
        if token != nil {
            isAuthenticated = true
            
            if let userId = defaults.object(forKey: "userid") {
                fetchUser(userId: userId as! String)
                print("User fetched")
            }
            
        }
        else {
            isAuthenticated = false
        }
    }
    
    //Environment Object
    static let shared = LoginViewModel()
    
    func login(email: String, password: String){
        let defaults = UserDefaults.standard
        WebService().login(email: email, password: password) { result in
            switch result {
                case .success(let user):
                    print(user.token)
                    defaults.set(user.token, forKey: "jsonwebtoken")
                    defaults.setValue(user.user.id, forKey: "userid")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        self.currentUser = user.user
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }
    
    func fetchUser(userId: String){
        let defaults = UserDefaults.standard
        WebService().fetchUser(id: userId) { result in
            switch result {
            case .success(let user):
                defaults.setValue(user.id, forKey: "userid")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.currentUser = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
