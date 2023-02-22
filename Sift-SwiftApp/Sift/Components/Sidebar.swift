//
//  Sidebar.swift
//  Sift
//
//  Created by Edward Day on 17/02/2023.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selectedTab: String
    @Namespace var animation
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            //MARK: Profile Section
            ZStack {
                Circle()
                    .frame(width: 68, height: 68, alignment: .center)
                    .foregroundColor(Color("StrokeGrey"))
                
                Image("Profile2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 46))
            }
            .padding(.top, 50)
            VStack(alignment: .leading, spacing: 6){
                Text("Jenny Lettings")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.black)
                Button {
                    //profile
                } label: {
                    Text("View Profile")
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
            }
            
            //MARK: Tab Buttons
            VStack(alignment: .leading, spacing: 10){
                SidebarTabButton(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                SidebarTabButton(image: "envelope.badge", title: "Inbox (3)", selectedTab: $selectedTab, animation: animation)
                SidebarTabButton(image: "bookmark", title: "Saved Properties", selectedTab: $selectedTab, animation: animation)
                SidebarTabButton(image: "gearshape", title: "Settings", selectedTab: $selectedTab, animation: animation)
                SidebarTabButton(image: "info.circle", title: "Help", selectedTab: $selectedTab, animation: animation)
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
            Spacer()
            
            //MARK: Sign Out section
            VStack(alignment: .leading){
                SidebarTabButton(image: "rectangle.righthalf.inset.filled.arrow.right", title: "Log Out", selectedTab: .constant(""), animation: animation)
                    .padding(.leading, -15)
                Text("Sift Version 0.1")
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .font(.system(size: 12))
            }
            
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
