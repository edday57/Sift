//
//  TabsView.swift
//  Sift
//
//  Created by Edward Day on 17/02/2023.
//

import SwiftUI

struct TabsView: View {
    @Binding var selectedTab: String
    let user: User
    @Binding var showingMenu: Bool
    let viewModel: PropertyModel
    init(selectedTab: Binding<String>, user: User, showingMenu: Binding<Bool>, viewModel: PropertyModel){
        self.viewModel = viewModel
        self.user = user
        self._showingMenu = showingMenu
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            //Tabs
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
                HomeView2(selectedTab: $selectedTab, viewModel: viewModel, user: user)
                    
            }
            .tabItem{
                Image(systemName: "house")
            }
            .tag("Home")
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
        }.edgesIgnoringSafeArea(.top)
            
            
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Demo: View {
    
    var body: some View{
        NavigationView{
            
            VStack(alignment: .leading,spacing: 20){
            
                
                VStack(alignment: .leading, spacing: 5, content: {
                    
                    Text("Jenna Ezarik")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("iJustine's Sister, YoutTuber ,Techie....")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                })
            }
            .navigationTitle("Home")
        }
        
    }
}

struct Demo2: View {
    
    var body: some View{
        VStack(spacing: 100){
            HStack(alignment: .top) {
                Text("demo")
                Spacer()
                
            }
            .padding(30)
            HStack(alignment: .top) {
                Text("demo")
                Spacer()
                
            }
            .padding(30)
            HStack(alignment: .top) {
                Text("demo")
                Spacer()
                
            }
            HStack(alignment: .top) {
                Text("demo")
                Spacer()
                
            }
            .padding(30)
        }

        
    }
}
