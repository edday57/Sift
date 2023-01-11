//
//  CardView.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import SwiftUI

struct CardView: View {
    //Properties
    let id = UUID()
    var property: Property
    
    var body: some View {
        Image(property.image)
            .resizable()
            .cornerRadius(24)
            .scaledToFit()
            .frame(minWidth: 0, maxWidth: .infinity)
            .shadow(radius: 5)
            .overlay(
                VStack(alignment: .center, spacing: 12, content: {
                    Text(property.address.uppercased())
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay (
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 1), alignment: .bottom
                        )
                    HStack(alignment: .center, spacing: 12) {
                        Text(property.postcode.uppercased())
                            .foregroundColor(Color.black)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(.leading, 10)
                            .padding(.vertical, 5)
                        Rectangle().frame(width: 1, height: 10, alignment: .center)
                        Text(String(property.price)+" pw")
                            .foregroundColor(Color.black)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(.trailing, 10)
                            .padding(.vertical, 5)
                    }.background(Capsule().fill(Color.white))
                    
            }
            )
                .frame(minWidth: 280)
                .padding(.bottom, 20),
                alignment: .bottom
                    
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(property: propertyData[1])
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
