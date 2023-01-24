//
//  Home.swift
//  Sift
//
//  Created by Edward Day on 24/01/2023.
//

import SwiftUI

struct Home: View {
    let user: User
    var body: some View {
        VStack{
            ZStack{
                TabView{
                    HomeView(user: user)
                        .tabItem{
                            Image(systemName: "house")
                        }
                    DiscoverView(user:user)
                        .tabItem{
                            Image(systemName: "heart.text.square")
                        }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(user: userDemo)
    }
}
