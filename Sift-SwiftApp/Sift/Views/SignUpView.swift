//
//  SignUpView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password=""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Welcome")
            TextField("Email", text: $email)
                .padding(20)
            SecureField("Password", text: $password)
                .padding(20)
            Button {
                //register()
            } label: {
                Text("Sign Up")
            }

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
