//
//  LoginViewModel.swift
//  Articulate
//
//  Created by Edward Day on 01/12/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    var email = ""
    var password = ""
    @Published var isAuthenticated = false
    
    
    func login(){
        let defaults = UserDefaults.standard
        WebService().login(email: email, password: password) { result in
            switch result {
                case .success(let user):
                    print(user.token!)
                    defaults.set(user.token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }
}
