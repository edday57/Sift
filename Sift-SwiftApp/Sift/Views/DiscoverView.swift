//
//  DiscoverView.swift
//  Sift
//
//  Created by Edward Day on 15/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    @ObservedObject var propertyModel = PropertyModel()
    let user: User
    var body: some View {
        VStack{
            CardDiscoverComponent(viewModel: PropertyCardModel(property: propertyModel.properties[0], currentUser: user))
            HStack(spacing: 30){
                Image(systemName: "arrow.uturn.left")
                    .labelStyle(.titleAndIcon)
                    .font(.system(size: 14).bold())
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(11)
                    .background(Rectangle()
                        .cornerRadius(13)
                        .foregroundColor(.white))
                        .shadow(radius: 5)
                Label("Get In Touch", systemImage: "envelope")
                    .labelStyle(.titleAndIcon)
                    .font(.system(size: 14).bold())
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(11)
                    .background(Rectangle()
                        .cornerRadius(13)
                        .foregroundColor(.white))
                        .shadow(radius: 5)
                Image(systemName: "bookmark")
                    .labelStyle(.titleAndIcon)
                    .font(.system(size: 14).bold())
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(11)
                    .background(Rectangle()
                        .cornerRadius(13)
                        .foregroundColor(.white))
                        .shadow(radius: 5)
            }
            .padding(20)
        }
        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PropertyModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return DiscoverView(propertyModel: viewModel, user: userDemo)
    }
}
