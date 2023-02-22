//
//  RatingBar.swift
//  Sift
//
//  Created by Edward Day on 22/02/2023.
//

import SwiftUI

struct RatingBar: View {
    var rating: Double
    var body: some View {
        ZStack(alignment: .center){
            GeometryReader { geo in
                Capsule()
                    .strokeBorder(.white, lineWidth: 2)
                    .background{
                        Capsule()
                            .foregroundColor(Color("RatingBackground"))
                            .shadow(color: .blue.opacity(0.2), radius: 3)
                        
                    }
                    .frame(width: geo.size.width, height: 10, alignment: .center)
                    
                Capsule()
                    .strokeBorder(.white, lineWidth: 2)
                    .background{
                        Capsule()
                            .foregroundColor(Color("PrimaryBlue"))
                        
                    }
                    .frame(width: geo.size.width * CGFloat(rating), height: 10, alignment: .center)
                    
            }
        }
    }
}

struct RatingBar_Previews: PreviewProvider {
    static var previews: some View {
        RatingBar(rating: 0.75)
    }
}
