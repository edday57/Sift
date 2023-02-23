//
//  ListingTags.swift
//  Sift
//
//  Created by Edward Day on 23/02/2023.
//

import SwiftUI

struct ListingTags: View {
    private var beds: Int
    private var baths: Int
    private var sqft: Int?
    
    init(beds: Int, baths: Int, sqft: Int? = nil){
        self.beds = beds
        self.baths = baths
        self.sqft = sqft
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18){
                HStack(spacing: 6){
                    Image(systemName: "bed.double")
                        .font(.system(size: 16, weight: .semibold))
                    Text(String(beds))
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 16, weight: .bold))
                    Text("Bedrooms")
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 12, weight: .bold))
                    
                }
                .frame(height: 35)
                .padding(.horizontal, 8)
                .background{
                    Rectangle()
                        .foregroundColor(Color("ListingTag"))
                        .shadow(color: .black.opacity(0.1) ,radius: 5, y: 4)
                        .border(Color("SecondaryTextLight"), width: 1)
                        
                        
                        
                }
                HStack(spacing: 6){
                    Image(systemName: "shower")
                        .font(.system(size: 16, weight: .semibold))
                    Text(String(baths))
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 16, weight: .bold))
                    Text("Bathrooms")
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 12, weight: .bold))
                    
                }
                .frame(height: 35)
                .padding(.horizontal, 8)
                .background{
                    Rectangle()
                        .foregroundColor(Color("ListingTag"))
                        .shadow(color: .black.opacity(0.1) ,radius: 5, y: 4)
                        .border(Color("SecondaryTextLight"), width: 1)
                }
                if sqft != nil {
                    HStack(spacing: 6){
                        Image(systemName: "square.dashed")
                            .font(.system(size: 16, weight: .semibold))
                        Text(String(sqft!))
                            .foregroundColor(Color("PrimaryBlue"))
                            .font(.system(size: 16, weight: .bold))
                        Text("sqft")
                            .foregroundColor(Color("PrimaryBlue"))
                            .font(.system(size: 12, weight: .bold))
                        
                    }
                    .frame(height: 35)
                    .padding(.horizontal, 8)
                    .background{
                        Rectangle()
                            .foregroundColor(Color("ListingTag"))
                            .shadow(color: .black.opacity(0.1) ,radius: 5, y: 4)
                            .border(Color("SecondaryTextLight"), width: 1)
                            
                            
                    }
                }
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            
        
        
        }
    }
}

struct ListingTags_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(viewModel: PropertyCardModel(property: propertyDemo, currentUser: userDemo, agent: agentDemo))
            .environmentObject(LikeModel(currentUser: userDemo))
    }
}
