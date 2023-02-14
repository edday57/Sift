//
//  HomeView.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    @EnvironmentObject var filtersModel: FiltersModel
    @ObservedObject var viewModel: PropertyModel
    let user: User
    
    var body: some View {

            ZStack {

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
//                                Button {
//                                    //
//                                } label: {
//                                    NavBarComponent(symbol: "magnifyingglass")
//                                }
                                NavigationLink {
                                    UserView(user: user, propertyModel: viewModel)
                                    
                                } label: {
                                    ProfileImageComponent(size: 44, image: self.user.image ?? "")
                                        .padding(.trailing, 20)
                                }
                                

                            }
                            .padding(.leading, 20)
                            .padding(.top,20)

                            
                            //Trending Section
                            HStack {
                                Text("My Collection")
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(20)
                                Spacer()
                                Button {
                                    selectedTab = "Saved"
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
                                    ForEach(Array(viewModel.savedProperties.prefix(5))){property in
                                        NavigationLink{
                                            ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                                        } label: {
                                            CardLargeComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                                        }
                                        
                                    }
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                               
                                
                            }
                            
                            //For You Section
                            HStack {
                                Text("Recently Added")
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
                            LazyVStack(spacing: -25){
                                ForEach(Array(viewModel.properties.prefix(5))){property in
                                    NavigationLink{
                                        ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                                    } label: {
                                        CardListComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                                    }
                                    
                                }
                            }
                                
                        }
                        .background(.clear)
                    
                }
                .background(.clear)
            }
            .background(.clear)

        
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PropertyModel()
        viewModel.savedProperties=[propertyDemo, propertyDemo2]
        viewModel.properties=[propertyDemo, propertyDemo2]
        return HomeView(selectedTab: .constant("Home"), viewModel: viewModel, user: userDemo)
            
    }
}
