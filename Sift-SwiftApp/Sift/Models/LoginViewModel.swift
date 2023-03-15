//
//  LoginViewModel.swift
//  Articulate
//
//  Created by Edward Day on 01/12/2022.
//

import Foundation
import GoogleSignIn
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
    
    func loginWithGoogle() {
        var idToken: String?
        let defaults = UserDefaults.standard
        //Sign in with Google
        GIDSignIn.sharedInstance.signIn(
          withPresenting: ApplicationUtility.rootViewController) { signInResult, error in
            guard let result = signInResult else {
              // Inspect error
              return
            }
              
              result.user.refreshTokensIfNeeded { user, error in
                      guard error == nil else { return }
                      guard let user = user else { return }

                    idToken = user.idToken?.tokenString
                  WebService().loginGoogle(idToken: idToken!){ result in
                      switch result{
                      case .success(let data):
                          defaults.set(data.token, forKey: "jsonwebtoken")
                          defaults.setValue(data.user.id, forKey: "userid")
                          DispatchQueue.main.async{
                              self.currentUser = data.user
                              self.isAuthenticated = true
                          }
                          
                          if data.newAccount == true{
                              //Present Google Additional sign up details
                          }
                          
                          print("User signed in with Google")
                      
                      case .failure(let error):
                          print(error.localizedDescription)
                          
                      }
                      
                  }
                  }
              
              print(result.user.profile!.email)

          }
        guard let idToken = idToken else { return }
        
        
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
    
    func checkEmailExists(email: String) async throws -> Bool {

        do {
            let data =  try await WebService().verifyEmail(email: email)
            print(data)
            return data
           
        } catch {
            print("error1")
            throw RuntimeError("Error while verifying email")
            //print("Error: ", error)
        }
            
    }
    
    func signUp(details: SignUpRequestBody) async{
        let defaults = UserDefaults.standard
        do {
            let data =  try await WebService().signUpUser(details: details)
            if data.status! == 200{
                //User signed up
                defaults.set(data.token, forKey: "jsonwebtoken")
                defaults.setValue(data.user!.id, forKey: "userid")
                await MainActor.run{
                    self.currentUser = data.user
                    self.isAuthenticated = true
                    
                }

            }
            else {
                //Present error
            }
        } catch(let error) {
            print(error)
            
        }

    }
}
