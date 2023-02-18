//
//  Home.swift
//  Sift
//
//  Created by Edward Day on 24/01/2023.
//

import SwiftUI

struct Home: View {
    let user: User
    @State var selectedTab = "Home"
    @ObservedObject var viewModel = PropertyModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                Image(systemName: "house")
                    .resizable()
                    .fixedSize()
                    .aspectRatio( contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:UIScreen.main.bounds.height)
                    .offset(x: -80, y: 300)
                    .font(.system(size: 500))
                    .opacity(0.05)
                VStack{
                    
                    ZStack{
                        TabView(selection: $selectedTab){
                            ZStack {
                                Image(systemName: "house")
                                    .resizable()
                                    .fixedSize()
                                    .aspectRatio( contentMode: .fill)
                                    .ignoresSafeArea()
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:UIScreen.main.bounds.height)
                                    .offset(x: -80, y: 300)
                                    .font(.system(size: 500))
                                    .opacity(0.05)
                                HomeView(selectedTab: $selectedTab, viewModel: viewModel, user: user)
                                    
                            }
                            .tabItem{
                                Image(systemName: "house")
                            }
                            .tag("Home")
                            .background(Color("Background"))
                            //.navigationBarHidden(true)
                            ZStack {
                                Image(systemName: "house")
                                    .resizable()
                                    .fixedSize()
                                    .aspectRatio( contentMode: .fill)
                                    .ignoresSafeArea()
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:UIScreen.main.bounds.height)
                                    .offset(x: -80, y: 300)
                                    .font(.system(size: 500))
                                    .opacity(0.05)
                                DiscoverView(user:user)
                            }
                            .tabItem{
                                Image(systemName: "heart.text.square")
                            }
                            .tag("Discover")
                            .background(Color("Background"))
                            ZStack {
                                Image(systemName: "house")
                                    .resizable()
                                    .fixedSize()
                                    .aspectRatio( contentMode: .fill)
                                    .ignoresSafeArea()
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:UIScreen.main.bounds.height)
                                    .offset(x: -80, y: 300)
                                    .font(.system(size: 500))
                                    .opacity(0.05)
                                BrowseView(user: user, viewModel: viewModel)
                                    
                            }
                            .tabItem{
                                Image(systemName: "magnifyingglass")
                            }
                            .tag("Browse")
                            .background(Color("Background"))
                            ZStack {
                                Image(systemName: "house")
                                    .resizable()
                                    .fixedSize()
                                    .aspectRatio( contentMode: .fill)
                                    .ignoresSafeArea()
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:UIScreen.main.bounds.height)
                                    .offset(x: -80, y: 300)
                                    .font(.system(size: 500))
                                    .opacity(0.05)
                                UserView(user:user, propertyModel: viewModel)
                            }
                            .tabItem{
                                Image(systemName: "person.fill")
                            }
                            .tag("Saved")
                            .background(Color("Background"))
                        }
                        .background(Color("Background"))
                        .edgesIgnoringSafeArea(.top)
                    }
                    .background(Color("Background"))
                }
                .navigationBarHidden(true)
            }
        }
    }
}


