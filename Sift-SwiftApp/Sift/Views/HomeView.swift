//
//  HomeView.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var propertyModel = PropertyModel()
    let user: User
    var body: some View {
        
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                    
                    VStack(alignment: .center, spacing: 8) {
                        //Nav
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
                                ProfileImageComponent(size: 44)
                                    .padding(.trailing, 20)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.bottom,20)
                        
                        //Top Buttons
                        HStack(alignment: .center) {
                            Text("All")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(5)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                .background(Capsule()
                                    .foregroundColor(Color("PrimaryBlue")))
                            Spacer()
                            Text("For You")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                .background(Capsule()
                                    .foregroundColor(Color("StrokeGrey")))
                            Spacer()
                            Text("Trending")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                .background(Capsule()
                                    .foregroundColor(Color("StrokeGrey")))
                            Spacer()
                            Text("Following")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.leading, 6)
                                .padding(.trailing, 6)
                                .background(Capsule()
                                    .foregroundColor(Color("StrokeGrey")))

                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 0)
                        
                        //Trending Section
                        HStack {
                            Text("Trending")
                                .font(.system(size: 24, weight: .bold))
                                .padding(20)
                            Spacer()
                            Button {
                                //for you
                            } label: {
                                Text("See More")
                                    .underline()
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(20)
                                    .foregroundColor(Color("TextGreyLight"))
                            }
                        }
                        
                        //Horizontal Large Cards
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 16){
                                ForEach(Array(propertyModel.properties.prefix(5))){property in
                                    CardLargeComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                           
                            
                        }
                        
                        //For You Section
                        HStack {
                            Text("For You")
                                .font(.system(size: 24, weight: .bold))
                                .padding(20)
                            Spacer()
                            Button {
                                //for you
                            } label: {
                                Text("See More")
                                    .underline()
                                    .font(.system(size: 14))
                                    .padding(20)
                                    .foregroundColor(Color("TextGreyLight"))
                                    
                            }
                        }
                        
                        //Filters
                        FiltersHScroll()

                        //Vertical Cards
                        VStack(spacing: -25){
                            ForEach(Array(propertyModel.properties.prefix(5))){property in
                                CardListComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                            }
                        }
                            
                    }
                
            }
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PropertyModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return HomeView(propertyModel: viewModel, user: userDemo)
            
    }
}
