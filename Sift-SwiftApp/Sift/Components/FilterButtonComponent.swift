//
//  FilterButtonComponent.swift
//  Sift
//
//  Created by Edward Day on 14/01/2023.
//

import SwiftUI

struct FilterButtonComponent: View {
    var label: String
    var image: String
    var body: some View {
        Label(label, systemImage: image)
            .labelStyle(.titleAndIcon)
            .font(.system(size: 14).bold())
            .foregroundColor(.white)
            .padding(11)
            .background(Rectangle()
                .cornerRadius(13)
                .foregroundColor(Color("PrimaryBlue")))
                .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 7)
    }
}

struct FiltersHScroll: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16){
                FilterButtonComponent(label: "Location", image: "mappin")
                FilterButtonComponent(label: "Price", image: "dollarsign")
                FilterButtonComponent(label: "Bedrooms", image:"bed.double.fill")
                FilterButtonComponent(label: "Bathrooms", image: "shower.fill")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
            
        }
        .padding(.vertical, -40)
    }
}

struct FilterButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonComponent(label: "Price", image: "dollarsign")
    }
}
