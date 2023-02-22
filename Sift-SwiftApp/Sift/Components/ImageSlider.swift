//
//  ImageSlider.swift
//  Sift
//
//  Created by Edward Day on 22/02/2023.
//

import SwiftUI

import Kingfisher

struct ImageSlider: View {
    
    // 1
    let images: [String]
    init(images: [String]) {
        self.images = images
    }
    
    var body: some View {
        // 2
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                KFImage(URL(string: item))
                    .resizable()
                    .scaledToFill()
                
            }
        }
        
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        // 4
        ImageSlider(images: [""])
            .previewLayout(.fixed(width: 400, height: 300))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
