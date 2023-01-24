//
//  DiscoverView.swift
//  Sift
//
//  Created by Edward Day on 15/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    @ObservedObject var viewModel = DiscoverViewModel()
    let user: User
    var body: some View {
            VStack{
                ZStack {
                    ForEach(Array(viewModel.properties.prefix(1))){ property in
                        CardDiscoverComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                            .animation(.spring())
                            .gesture(DragGesture()
                                                        .onEnded { value in
                                                            if value.translation.width < -100 {
                                                                //self.viewedCards.append(card)
                                                                self.viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                                            }
                                                            if value.translation.width > 100 {
                                                                //self.viewedCards.append(card)
                                                                self.viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                                            }
                                                        }
                                                    )
                            .transition(.slide)
                            .animation(.spring())
                    }
                }
                
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
        let viewModel = DiscoverViewModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return DiscoverView(viewModel: viewModel, user: userDemo)
    }
}
