//
//  ContentView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        if loginVM.isAuthenticated == true{
            if let user = loginVM.currentUser{
                Home(user:user)
            }
            
        }
        else{
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
