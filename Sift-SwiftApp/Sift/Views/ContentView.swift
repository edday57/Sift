//
//  ContentView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        if loginVM.isAuthenticated == true{
            if let user = loginVM.currentUser{
                var likeModel = LikeModel(currentUser: user)
                let loc = CLLocation(latitude: 51.527851, longitude: -0.079498)
                MainView(user: user)
                    .environmentObject(likeModel)
                   // .environmentObject(loc)
                //Home(user:user)
                    //.environmentObject(likeModel)
            }
            
        }
        else{
            NavigationStack {
                //SignUpView1()
                OnboardingView()
            }
            
            //LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
