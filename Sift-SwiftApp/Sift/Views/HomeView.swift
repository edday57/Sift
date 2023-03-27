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
                                
                                
                                Spacer()
//                                Button {
//                                    //
//                                } label: {
//                                    NavBarComponent(symbol: "magnifyingglass")
//                                }
//                                NavigationLink {
//                                    UserView(user: user, propertyModel: viewModel)
//
//                                } label: {
//                                    ProfileImageComponent(size: 44, image: self.user.image ?? "")
//                                        .padding(.trailing, 20)
//                                }
                                

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
                                    ForEach(Array(viewModel.properties.prefix(5))){property in
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

struct HomeView2: View {
    @Binding var showingMenu: Bool
    @Binding var selectedTab: String
    @EnvironmentObject var filtersModel: FiltersModel
    @ObservedObject var viewModel: PropertyModel
    @State private var showingFilters = false
    let user: User
    @State private var searchTerm = ""
    
    var body: some View {

            ZStack {

                ScrollView {
                        
                        VStack(alignment: .center, spacing: 8) {
                            //Nav
                            Button {
                                withAnimation(.spring()){
                                    showingMenu.toggle()
                                }
                            } label: {
                                MenuIcon().frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 20)
                                    .opacity(showingMenu ? 0: 1)
                            }
                            
                            //Trending Section
                            Text("Explore Property")
                                .font(.system(size: 20, weight: .black))
                                .foregroundColor(Color("PrimaryText"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(20)
                            
                            //MARK: Search Bar
                            HStack{
                                SearchBar(searchTerm: $searchTerm)
                                Button {
                                    showingFilters.toggle()
                                } label: {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(Color("SecondaryText"))
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .fullScreenCover(isPresented: $showingFilters) {
                                    FiltersView(parent: refresh)
                                        
                                }

                                
                            }
                            .padding(.horizontal, 20)
                            
                            //MARK: Filters
                            ScrollView(.horizontal){
                                HStack(spacing:12) {
                                    
                                    if filtersModel.filters.property_type.count != 0{
                                        ForEach(Array((filtersModel.filters.property_type)), id: (\.self)){ type in
                                            Button {
                                                filtersModel.filters.property_type.remove(object: type)
                                                filtersModel.filters.saveFiltersToUserDefaults()
                                                viewModel.refreshProperties()
                                            } label: {
                                                
                                                Label(type, systemImage: "xmark")
                                                    .filterTag()

                                            }
                                        }
                                    }
                                    if filtersModel.filters.minPrice != 100 || filtersModel.filters.maxPrice != 20000{
                                        Button {
                                            filtersModel.filters.minPrice = 100
                                            filtersModel.filters.maxPrice = 20000
                                            filtersModel.filters.saveFiltersToUserDefaults()
                                            viewModel.refreshProperties()
                                        } label: {
                                            
                                            Label("Price", systemImage: "xmark")
                                                .filterTag()
                                                

                                        }
                                        
                                    }
                                    
                                    if filtersModel.filters.maxBeds != -1{
                                        Button {
                                            filtersModel.filters.minBeds = -1
                                            filtersModel.filters.maxBeds = -1
                                            filtersModel.filters.saveFiltersToUserDefaults()
                                            viewModel.refreshProperties()
                                        } label: {
                                            
                                            Label("Bedrooms", systemImage: "xmark")
                                                .filterTag()

                                        }
                                    }
                                    if filtersModel.filters.maxBaths != -1 {
                                        Button {
                                            filtersModel.filters.minBaths = -1
                                            filtersModel.filters.maxBaths = -1
                                            filtersModel.filters.saveFiltersToUserDefaults()
                                            viewModel.refreshProperties()
                                        } label: {
                                            
                                            Label("Bathrooms", systemImage: "xmark")
                                                .filterTag()

                                        }
                                    }
                                    if filtersModel.filters.minSize != 100 || filtersModel.filters.maxSize != 5000{
                                        Button {
                                            filtersModel.filters.minSize = 100
                                            filtersModel.filters.maxSize = 5000
                                            filtersModel.filters.saveFiltersToUserDefaults()
                                            viewModel.refreshProperties()
                                        } label: {
                                            
                                            Label("Size", systemImage: "xmark")
                                                .filterTag()

                                        }
                                    }
                                } //Filters HStack
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            }
                            
                            //MARK: Browse Cards
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 16){
                                    ForEach(Array(viewModel.properties.prefix(5))){property in
                                        NavigationLink{
                                            ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                                        } label: {
                                            CardLargeComponentNew(viewModel: PropertyCardModel(property: property, currentUser: user))
                                        }
                                        
                                    }
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                               
                                
                            }
                           

                            //For You Section
                            HStack {
                                Text("For You")
                                    .font(.system(size: 20, weight: .black))
                                    .foregroundColor(Color("PrimaryText"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(20)
                                Spacer()
                                Button {
                                    //for you
                                } label: {
                                    Text("See More")
                                        .underline()
                                        .font(.system(size: 14, weight: .bold))
                                        .padding(20)
                                        .foregroundColor(Color("SecondaryText"))
                                        
                                }
                            }
                           
                            //Vertical Cards
                            LazyVStack(alignment: .center){
                                ForEach(Array(viewModel.savedProperties.prefix(5))){property in
                                    NavigationLink{
                                        ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                                    } label: {
                                        CardDiscoverComponentNew(viewModel: PropertyCardModel(property: property, currentUser: user))
                                            .padding(.bottom, 5)
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
    
    func refresh(){
        viewModel.refreshProperties()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PropertyModel()
        viewModel.savedProperties=[propertyDemo, propertyDemo2]
        viewModel.properties=[propertyDemo, propertyDemo2]
        return HomeView2(showingMenu: .constant(false),selectedTab: .constant("Home"), viewModel: viewModel, user: userDemo)
            
    }
}
