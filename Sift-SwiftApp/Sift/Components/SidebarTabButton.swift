//
//  SidebarTabButton.swift
//  Sift
//
//  Created by Edward Day on 17/02/2023.
//

import SwiftUI

struct SidebarTabButton: View {
    var image: String
    var title: String
    
    @Binding var selectedTab: String
    var animation: Namespace.ID
    var body: some View {
       
        Button {
            withAnimation(.spring()){
                selectedTab = title
            }
            if title == "Log out"{
                //log out user
            }
        } label: {
            HStack(spacing: 15){
                Image(systemName: image)
                    .frame(width: 30)
                Text(title)
                    .fontWeight(title == "Log Out" ? .semibold : .black)
            }
            .foregroundColor(selectedTab == title ? Color("PrimaryBlue") : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background{
                ZStack{
                    if selectedTab == title{
                        Color.white
                            .opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 8))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                
            }
        }

    }
}

struct SidebarTabButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
