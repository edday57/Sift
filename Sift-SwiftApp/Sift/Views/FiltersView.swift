//
//  FiltersView.swift
//  Sift
//
//  Created by Edward Day on 01/02/2023.
//

import SwiftUI

struct FiltersView: View {
    //@State var filters = Filters.
    var refreshParent: () -> Void
    @EnvironmentObject var filtersModel: FiltersModel
    @State var filters: Filters
    @Environment(\.dismiss) var dismiss
    @State var priceSliderPosition: ClosedRange<Float>
    @State var sizeSliderPosition: ClosedRange<Float>
    @State var propertyTypes: [String] = ["Apartment",   "Bungalow",
                                           "Cottage",     "Detached",
                                           "Duplex",      "End of Terrace",
                                           "Flat",        "Flat Share",
                                           "Ground Flat", "House",
                                           "House Share", "Link Detached House",
                                           "Maisonette",  "Mews",
                                           "Penthouse",   "Semi-Detached",
                                           "Terraced",    "Town House"
    ]
    @State var bedrooms: [Int] = [1, 2, 3, 4]
    @State var bathrooms: [Int] = [1, 2, 3, 4]

    init(parent: @escaping () -> Void){
        refreshParent = parent
        _filters = State(initialValue: Filters.loadFiltersFromUserDefaults())
        _priceSliderPosition = State(initialValue: Float(_filters.wrappedValue.minPrice)...Float(_filters.wrappedValue.maxPrice))
        _sizeSliderPosition = State(initialValue: Float(_filters.wrappedValue.minSize)...Float(_filters.wrappedValue.maxSize))
    }
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    //Top Bar
                    HStack{
                        Button(action: {
                            dismiss()
                            
                        }, label: {
                            Image(systemName: "xmark")
                                .bold()
                                .foregroundColor(Color("TextGreyDark"))
                        })
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Filters")
                            .frame(maxWidth: .infinity, alignment: .center)
                        Button {
                            filters.minBaths = -1
                            filters.maxBaths = -1
                            filters.minBeds = -1
                            filters.maxBeds = -1
                            filters.property_type.removeAll()
                            priceSliderPosition = 100...20000
                            sizeSliderPosition = 100...5000
                        } label: {
                            Text("Reset")
                                .foregroundColor(.white)
                                .padding(11)
                                .background(RoundedRectangle(cornerRadius: 11)
                                    .cornerRadius(13)
                                    .foregroundColor(Color("PrimaryBlue")))
                                    .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 2)
                                    .font(.system(size: 14, weight: .bold))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(20)
                    
                    Text("Property Type")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .font(.system(size: 24, weight: .bold))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20){
                            Button {
                                filters.property_type.removeAll()
                            } label: {
                                Text("Any")
                                    .filterStyle()
                                    
                            }
                            ForEach(0..<propertyTypes.count, id: \.self){ index in
                                Button {
                                    if !filters.property_type.contains(propertyTypes[index]) {
                                        filters.property_type.append(propertyTypes[index])
                                    }
                                    else{
                                        filters.property_type.remove(object: propertyTypes[index])
                                    }
                                } label: {
                                    if !filters.property_type.contains(propertyTypes[index]){
                                        Text(propertyTypes[index])
                                            .filterStyle()
                                    }
                                    else{
                                        Text(propertyTypes[index])
                                            .filterSelectedStyle()
                                    }
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    Group{
                        HStack {
                            Text("Price Per Month")
                                .padding(20)
                                .font(.system(size: 24, weight: .bold))
                                .lineLimit(1)
                            Spacer()
                            Text("£\(String(format: "%0.f", roundNumber(Double(priceSliderPosition.lowerBound), toNearest: 100))) - £\(String(format: "%0.f", roundNumber(Double(priceSliderPosition.upperBound), toNearest: 100)))")
                                .padding(20)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color("PrimaryBlue"))
                        }
                        RangedSliderView(value: $priceSliderPosition, bounds: 100...20000)
                            .padding(.horizontal, 30)
                    }

                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                    
                    Group{
                        Text("Bedrooms")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(20)
                            .font(.system(size: 24, weight: .bold))
                        HStack(spacing:20){
                            Button {
                                filters.minBeds = -1
                                filters.maxBeds = -1
                            } label: {
                                Text("Any")
                                    .filterStyle()
                            }
                            ForEach(0..<bedrooms.count, id: \.self){ index in
                                Button {
                                    
                                    if filters.minBeds == -1 {
                                        filters.minBeds = bedrooms[index]
                                        filters.maxBeds = bedrooms[index]
                                    }
                                    else if filters.minBeds > bedrooms[index] {
                                        filters.minBeds = bedrooms[index]
                                    }
                                    else if filters.maxBeds < bedrooms[index] {
                                        filters.maxBeds = bedrooms[index]
                                    }
                                    else{
                                        deselectNumber(numberToDeselect: bedrooms[index], filter: "Bed")
                                    }
                                } label: {
                                    if filters.minBeds <= bedrooms[index] && filters.maxBeds >= bedrooms[index]{
                                        if bedrooms[index]==4{
                                            Text("4+")
                                                .filterSelectedStyle()
                                        }
                                        else{
                                            Text(String(bedrooms[index]))
                                                .filterSelectedStyle()
                                        }
                                        
                                    }
                                    else{
                                        if bedrooms[index]==4{
                                            Text("4+")
                                                .filterStyle()
                                        }
                                        else{
                                            Text(String(bedrooms[index]))
                                                .filterStyle()
                                        }
                                    }
                                    
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                    
                    Group{
                        Text("Bathrooms")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(20)
                            .font(.system(size: 24, weight: .bold))
                        HStack(spacing:20){
                            Button {
                                filters.minBaths = -1
                                filters.maxBaths = -1
                            } label: {
                                Text("Any")
                                    .filterStyle()
                            }
                            ForEach(0..<bathrooms.count, id: \.self){ index in
                                Button {
                                    
                                    if filters.minBaths == -1 {
                                        filters.minBaths = bathrooms[index]
                                        filters.maxBaths = bathrooms[index]
                                    }
                                    else if filters.minBaths > bathrooms[index] {
                                        filters.minBaths = bathrooms[index]
                                    }
                                    else if filters.maxBaths < bathrooms[index] {
                                        filters.maxBaths = bathrooms[index]
                                    }
                                    else{
                                        deselectNumber(numberToDeselect: bathrooms[index], filter: "Bath")
                                    }
                                } label: {
                                    if filters.minBaths <= bathrooms[index] && filters.maxBaths >= bathrooms[index]{
                                        if bathrooms[index]==4{
                                            Text("4+")
                                                .filterSelectedStyle()
                                        }
                                        else{
                                            Text(String(bathrooms[index]))
                                                .filterSelectedStyle()
                                        }
                                        
                                    }
                                    else{
                                        if bathrooms[index]==4{
                                            Text("4+")
                                                .filterStyle()
                                        }
                                        else{
                                            Text(String(bathrooms[index]))
                                                .filterStyle()
                                        }
                                    }
                                    
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }

                    Group{
                        Divider()
                            .padding(.horizontal, 20)
                            .padding(.top, 30)
                        HStack {
                            Text("Property Size (sqft)")
                                .padding(20)
                                .font(.system(size: 24, weight: .bold))
                                .lineLimit(1)
                            Spacer()
                            Text("\(String(format: "%0.f", sizeSliderPosition.lowerBound)) - \(String(format: "%0.f", sizeSliderPosition.upperBound))")
                                .padding(20)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color("PrimaryBlue"))
                        }
                        RangedSliderView(value: $sizeSliderPosition, bounds: 100...5000)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 300)
                    }
                    


                    

                    
                }
            }
            VStack{
                Spacer()
                Button {
                    saveFilters()
                    refreshParent()
                    dismiss()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 11)
                            .cornerRadius(13)
                            .foregroundColor(Color("PrimaryBlue"))
                            .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 2)
                            .frame(height: 42)
                            .padding(30)
                        Text("Show Listings")
                            .foregroundColor(.white)
                            .padding(14)
                            .font(.system(size: 14, weight: .bold))
                    }
                    
                }

            }
        }
    }
    func saveFilters(){
        filters.minPrice = Int(priceSliderPosition.lowerBound)
        filters.maxPrice = Int(priceSliderPosition.upperBound)
        filters.minSize = Int(sizeSliderPosition.lowerBound)
        filters.maxSize = Int(sizeSliderPosition.upperBound)
        filtersModel.filters = filters
        filtersModel.filters.saveFiltersToUserDefaults()
    }

    
    func deselectNumber(numberToDeselect: Int, filter: String){
        if filter == "Bath"{
            if numberToDeselect == filters.minBaths && numberToDeselect == filters.maxBaths{
                filters.minBaths = -1
                filters.maxBaths = -1
            }
            else if numberToDeselect == filters.minBaths{
                filters.minBaths = numberToDeselect + 1
            }
            else if numberToDeselect == filters.maxBaths{
                filters.maxBaths = numberToDeselect - 1
            }
            if numberToDeselect > filters.minBaths && numberToDeselect < filters.maxBaths{
                if filters.maxBaths - filters.minBaths == 2{
                    filters.minBaths = numberToDeselect
                    filters.maxBaths = numberToDeselect
                }
                else{
                    if numberToDeselect == 2{
                        filters.minBaths = numberToDeselect
                    }
                    else{
                        filters.maxBaths = numberToDeselect
                    }
                }
            }
        }
        else if filter == "Bed"{
            if numberToDeselect == filters.minBeds && numberToDeselect == filters.maxBeds{
                filters.minBeds = -1
                filters.maxBeds = -1
            }
            else if numberToDeselect == filters.minBeds{
                filters.minBeds = numberToDeselect + 1
            }
            else if numberToDeselect == filters.maxBeds{
                filters.maxBeds = numberToDeselect - 1
            }
            if numberToDeselect > filters.minBeds && numberToDeselect < filters.maxBeds{
                if filters.maxBeds - filters.minBeds == 2{
                    filters.minBeds = numberToDeselect
                    filters.maxBeds = numberToDeselect
                }
                else{
                    if numberToDeselect == 2{
                        filters.minBeds = numberToDeselect
                    }
                    else{
                        filters.maxBeds = numberToDeselect
                    }
                }
            }
        }
        
    }
    func roundNumber(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
}

extension Text {
    func filterSelectedStyle() -> some View {
        self.foregroundColor(.white)
            .padding(14)
            .font(.system(size: 14, weight: .bold))
            .background(RoundedRectangle(cornerRadius: 11)
                .cornerRadius(13)
                .foregroundColor(Color("PrimaryBlue")))
                .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 2)
                
    }
    
    func filterStyle() -> some View {
        self.foregroundColor(Color("TextGreyDark"))
            .padding(14)
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

extension Label {
    func filterTag() -> some View {
        self.foregroundColor(Color("SecondaryText"))
            .padding(9)
            .font(.system(size: 14, weight: .bold))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color("SecondaryTextLight"), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 11)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 4)
                    )
            )
                
    }
    
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        func refresh(){
            
        }
        return FiltersView(parent: refresh)
    }
}
extension Array where Element: Equatable {

 // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
        
    }
 }
