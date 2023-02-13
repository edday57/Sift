//
//  UserView.swift
//  Sift
//
//  Created by Edward Day on 27/01/2023.
//

import SwiftUI

struct UserView: View {
    let user: User
    @EnvironmentObject var filtersModel: FiltersModel
    @ObservedObject var propertyModel: PropertyModel
    @State private var showingFilters = false
    var body: some View {

        ZStack{
            ScrollView{
                VStack(){
                    //Profile Section
                    HStack{
                        ProfileImageComponent(size: 80, image: user.image ?? "")
                            .padding(.trailing, 14)
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(user.name ?? "")
                                    .font(.system(size: 20, weight: .bold))
                                Spacer()
                                Text("settings")
                            }
                            Text(user.about ?? "")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("TextGreyLight"))
                        }
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    
                    //Collection Section
                    HStack{
                        Text("My Collection")
                            .font(.system(size: 24, weight: .bold))
                            
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    //Filters
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
                                        propertyModel.refreshSavedProperties()
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
                                    propertyModel.refreshSavedProperties()
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
                                    propertyModel.refreshSavedProperties()
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
                                    propertyModel.refreshSavedProperties()
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
                                    propertyModel.refreshSavedProperties()
                                } label: {
                                    
                                    Label("Size", systemImage: "xmark")
                                        .filterTag()

                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        
                        

                    }

                    //Liked Property Cards
                    LazyVStack(spacing: -20){
                        ForEach(Array(propertyModel.savedProperties.prefix(10))){property in
                            NavigationLink{
                                ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                            } label: {
                                CardListComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                            }
                            
                        }
                    }
                }
            }
            .refreshable {
                propertyModel.refreshSavedProperties()
            }
        }
        

    }
    func refresh(){
        propertyModel.refreshSavedProperties()
    }
}

extension Label {
    func filterTag() -> some View {
        self.foregroundColor(Color("TextGreyDark"))
            .padding(11)
            .font(.system(size: 14, weight: .bold))
            .background(
                RoundedRectangle(cornerRadius: 11)
                    .strokeBorder(Color("StrokeGrey"), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 11)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.05), radius: 3)
                    )
            )
                
    }
    
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let propertyModel = PropertyModel()
        propertyModel.savedProperties=[propertyDemo, propertyDemo2]
        return UserView(user: userDemo, propertyModel: propertyModel)
    }
}
