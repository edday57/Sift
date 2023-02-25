//
//  DiscoverView.swift
//  Sift
//
//  Created by Edward Day on 15/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    @Binding var showingMenu: Bool
    @ObservedObject var viewModel = DiscoverViewModel()
    let user: User
    @State var viewedProperties: [String] = ["63c8279a5b061b24d6897c5d"]
    var body: some View {
        VStack(spacing: 0){
            Button {
                withAnimation(.spring()){
                    showingMenu.toggle()
                }
            } label: {
                MenuIcon().frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .opacity(showingMenu ? 0: 1)
            }

            
            HStack{
                Text("For You")
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(Color("PrimaryText"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                Image(systemName: "info.circle")
            }
            .padding(20)
            //.padding(.top, 40)
            Spacer()
                ZStack {
                    ForEach(Array(viewModel.properties.prefix(1))){ property in
                        CardSwipeComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
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
            HStack(spacing: 0){
                ZStack{
                    Rectangle()
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                        .frame(height: 70)
                        .foregroundColor(Color("PrimaryBlue"))
                        .overlay(alignment: .trailing) {
                            Triangle()
                                .frame(width: 20)
                                .foregroundColor(.white)
                        }
                    Text("Save Listing")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .heavy))
                }
                ZStack{
                    Rectangle()
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .frame(height: 70)
                        .foregroundColor(.white)
                    Text("Contact Agent")
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 16, weight: .semibold))
                }
                
                
            }
            
            .background{
                Color.white
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(20)
            .cornerRadius(10)
            }

        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DiscoverViewModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return DiscoverView(showingMenu: .constant(true),viewModel: viewModel, user: userDemo)
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
