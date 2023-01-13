//
//  ContentView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if LoginViewModel().isAuthenticated == true{
            HomeView()
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
