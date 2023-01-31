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
                    HStack(){
                        Button {
                            //
                        } label: {
                            NavBarComponent(symbol: "list.bullet")
                        }
                        
                        Spacer()
                        Button {
                            //
                        } label: {
                            NavBarComponent(symbol: "magnifyingglass")
                        }
                        Button {
                            //
                        } label: {
                            ProfileImageComponent(size: 44, image: self.user.image ?? "")
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.bottom,8)
                    ZStack{
                        TabView{
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
                                HomeView(user: user)
                                    
                            }
                            .tabItem{
                                Image(systemName: "house")
                            }
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
                                SavedView(user:user)
                            }
                            .tabItem{
                                Image(systemName: "bookmark")
                            }
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(user: userDemo)
    }
}
