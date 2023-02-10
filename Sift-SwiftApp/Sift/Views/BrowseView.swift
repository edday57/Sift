//
//  BrowseView.swift
//  Sift
//
//  Created by Edward Day on 01/02/2023.
//

import SwiftUI

struct BrowseView: View {
    let user: User
    @State private var searchTerm = ""
    @EnvironmentObject var filtersModel: FiltersModel
    @State private var showingFilters = false
    @ObservedObject var viewModel: PropertyModel
    var body: some View {
        
        ScrollView(){
            VStack{
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
                        CardFullWidthListComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            
                    }
                    .onAppear(){
                        loadMore(currentListing: property)
                    }
                    
                }
            }//VStack
            
            
        }// Scroll View
        .refreshable {
            viewModel.getProperties()
        }
        


    }
        
        
    func refresh(){
        viewModel.getProperties()
        
    }
    
    func loadMore(currentListing: Property){
        if viewModel.properties.count >= 10 {
            if viewModel.properties[viewModel.properties.count - 2].id == currentListing.id{
                print("load more")
                print(currentListing.address)
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
