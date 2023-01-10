//
//  LoginView.swift
//  Homie
//
//  Created by Edward Day on 16/11/2022.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {
    @State private var email = ""
    @State private var password=""
    @State private var userIsLoggedIn=false
    var body: some View {
        if userIsLoggedIn {
            //
        }
        else{
            content
        }

    }
    
    var content: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Welcome")
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button {
                register()
            } label: {
                Text("Sign Up")
            }
            Button {
                login()
            } label: {
                Text("Log In")
            }

        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
    }
    
    //Functions
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }

}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
