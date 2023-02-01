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
    @State var viewedProperties: [String] = ["63c8279a5b061b24d6897c5d"]
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("For You")
                    .font(.system(size: 30, weight: .bold))
                    
                Spacer()
                Image(systemName: "info.circle")
            }
            .padding(.horizontal,30)
            .padding(.top,20)
                ZStack {
                    ForEach(Array(viewModel.properties.prefix(1))){ property in
                        NavigationLink{
                            ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                        } label: {
                            CardDiscoverComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                                
                        }
                        .buttonStyle(FlatLinkStyle())
                        .animation(.spring())
                        .simultaneousGesture(DragGesture()
                                                    .onEnded { value in
                                                        
                                                        if value.translation.width < -100 {
                                                            self.viewedProperties.append(property.id)
                                                            //self.viewedCards.append(card)
                                                            self.viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                                            if viewModel.properties.isEmpty{
                                                                viewModel.getProperties(viewed: viewedProperties)
                                                            }
                                                        }
                                                        if value.translation.width > 100 {
                                                            self.viewedProperties.append(property.id)
                                                            //Add like
                                                            print("add like")
                                                            PropertyCardModel(property: property, currentUser: user).addLike()
                                                            //Get properties
                                                            self.viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                                            if viewModel.properties.isEmpty{
                                                                viewModel.getProperties(viewed: viewedProperties)
                                                            }
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

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
