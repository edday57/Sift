//
//  BrowseView.swift
//  Sift
//
//  Created by Edward Day on 01/02/2023.
//

import SwiftUI

struct BrowseView2: View {
    let user: User
    
    @State private var searchTerm = ""
    @EnvironmentObject var filtersModel: FiltersModel
    @State private var showingFilters = false
    @ObservedObject var viewModel: PropertyModel
    var body: some View {
            ScrollView {
                
                LazyVStack(alignment: .center, spacing: 8) {
                    //Nav
                    
                    
                    //Trending Section
                    Text("Explore Property")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(Color("PrimaryText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .padding(.top, 40)
                    
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
                    
                    //Vertical Cards
                    ForEach(Array(viewModel.properties)){property in
                        NavigationLink{
                            ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                        } label: {
                            LazyVStack{
                                CardDiscoverComponentNew(viewModel: PropertyCardModel(property: property, currentUser: user))
                                    .padding(.bottom, 5)
                                    .onAppear(){
                                        loadMore(currentListing: property)
                                    }
                            }
                                             
                        }
                        
                    }
                    
                }
                .background(.clear)
                
            }
            .background(.clear)
        
        
        
    }
        
        
    func refresh(){
        viewModel.refreshProperties()
        
    }
    
    func loadMore(currentListing: Property){
        if viewModel.properties.count >= 10 {
            if viewModel.properties[viewModel.properties.count - 2].id == currentListing.id{
                print("load more")
                viewModel.browseSkip += 10
                viewModel.getProperties()
                //print(currentListing.address)
            }
        }
    }
}

struct BrowseView: View {
    let user: User
    @State private var searchTerm = ""
    @EnvironmentObject var filtersModel: FiltersModel
    @State private var showingFilters = false
    @ObservedObject var viewModel: PropertyModel
    var body: some View {
        
        ScrollView(){
            LazyVStack{
                SearchBar(searchTerm: $searchTerm)
                .padding(.vertical, 8)
                ScrollView(.horizontal){
                    HStack(spacing:12) {
                        Button {
                            showingFilters.toggle()
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                                .foregroundColor(.white)
                                .padding(11)
                                .background(RoundedRectangle(cornerRadius: 11)
                                    .cornerRadius(13)
                                    .foregroundColor(Color("PrimaryBlue")))
                                    .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 2)
                                    .font(.system(size: 14, weight: .bold))
                        }
                        .fullScreenCover(isPresented: $showingFilters) {
                            FiltersView(parent: refresh)
                                
                        }
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
                    .padding(.vertical, 5)
                }
                
                HStack{
                    Text("Properties")
                        .font(.system(size: 30, weight: .bold))
                        
                    Spacer()
                    Text("Most Recent")
                        .underline()
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("TextGreyLight"))
                }
                .padding(.horizontal,24)
                
                ForEach(Array(viewModel.properties)){property in
                    NavigationLink{
                        ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                    } label: {
                        LazyVStack{
                            CardFullWidthListComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                .onAppear(){
                                    loadMore(currentListing: property)
                                }
                        }
                                         
                    }
                    
                }
            }//VStack
            
            
        }// Scroll View
        .refreshable {
            viewModel.refreshProperties()
        }
        


    }
        
        
    func refresh(){
        viewModel.refreshProperties()
        
    }
    
    func loadMore(currentListing: Property){
        if viewModel.properties.count >= 10 {
            if viewModel.properties[viewModel.properties.count - 2].id == currentListing.id{
                print("load more")
                viewModel.browseSkip += 10
                viewModel.getProperties()
                //print(currentListing.address)
            }
        }
    }
}


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PropertyModel()
        viewModel.savedProperties=[propertyDemo, propertyDemo2]
        viewModel.properties=[propertyDemo, propertyDemo2]
        return BrowseView(user: userDemo, viewModel: viewModel)
    }
}
