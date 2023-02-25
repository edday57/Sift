//
//  MainView.swift
//  Sift
//
//  Created by Edward Day on 17/02/2023.
//

import SwiftUI

struct MainView: View {
    let user: User
    let mainTabs = ["Home", "Discover", "Browse", "Saved"]
    @State var selectedTab = "Home"
    @State var showingMenu = false
    @ObservedObject var viewModel = PropertyModel()
    var body: some View {
        NavigationStack {
            ZStack{
                Color("PrimaryBlue")
                    .ignoresSafeArea()
                
               //MARK: Sidebar
                Sidebar(showingMenu: $showingMenu, selectedTab: $selectedTab)
                
                //MARK: Tabs
                ZStack{
                    Color.white
                        .opacity(0.3)
                        .cornerRadius(showingMenu ? 15 : 0)
                        .offset(x: showingMenu ? -25 : 0)
                        .padding(.vertical, 30)
                    Color.white
                        .opacity(0.3)
                        .cornerRadius(15)
                        .offset(x: showingMenu ? -50 : 0)
                        .padding(.vertical, 60)
                    SecondaryTabsView(selectedTab: $selectedTab, user: user, showingMenu: $showingMenu, viewModel: viewModel)
                        .cornerRadius(showingMenu ? 15 : 10)
                        .disabled(showingMenu)
                    
                    TabsView(selectedTab: $selectedTab, user: user, showingMenu: $showingMenu, viewModel: viewModel)
                        .cornerRadius(showingMenu ? 15 : 10)
                        .disabled(showingMenu)
                        .opacity(mainTabs.contains(selectedTab) ? 1: 0)
    //                    .overlay(content: {
    //                        if showingMenu{
    //                            Color.white
    //                                .ignoresSafeArea()
    //                                .opacity(0.5)
    //                                .cornerRadius(showingMenu ? 15 : 10)
    //                        }
    //                    })
    //                    .opacity(showingMenu ? 1 : 1)
                        
                }
                .scaleEffect(showingMenu ? 0.85 : 1)
                .offset(x: showingMenu ? getRect().width - 120 : 0)
                .ignoresSafeArea()
//                .overlay(
//                
//                    // Menu Button...
//                    Button(action: {
//                        withAnimation(.spring()){
//                            showingMenu.toggle()
//                        }
//                    }, label: {
//                        
//                        // Animted Drawer Button..
//                        VStack(spacing: 5){
//                            
//                            Capsule()
//                                .fill(showingMenu ? Color.white : Color("PrimaryText"))
//                                .frame(width: 30, height: 3)
//                            // Rotating...
//                                .rotationEffect(.init(degrees: showingMenu ? -45 : 0))
//                                .offset(x: showingMenu ? 2 : 0, y: showingMenu ? 9 : 0)
//
//                            VStack(spacing: 5){
//                                
//                                Capsule()
//                                    .fill(showingMenu ? Color.white : Color("PrimaryText"))
//                                    .frame(width: 30, height: 3)
//                                // Moving Up when clicked...
//                                Capsule()
//                                    .fill(showingMenu ? Color.white : Color("PrimaryText"))
//                                    .frame(width: 30, height: 3)
//                                    .offset(y: showingMenu ? -8 : 0)
//                            }
//                            .rotationEffect(.init(degrees: showingMenu ? 45 : 0))
//                        }
//                        .contentShape(Rectangle())
//                    })
//                    .padding()
//                    .offset(x: 3)
//                    
//                    ,alignment: .topLeading
//                )
                
                    
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}
