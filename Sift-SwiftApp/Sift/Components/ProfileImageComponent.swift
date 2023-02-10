//
//  ProfileImageComponent.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI
import Kingfisher

struct ProfileImageComponent: View {
    var size = 0.0
    var image: String
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size, alignment: .center)
                .foregroundColor(Color("StrokeGrey"))

                KFImage(URL(string: image))
                .resizable()
                .scaledToFill()
                .frame(width: size-2, height: size-2)
                .clipShape(RoundedRectangle(cornerRadius: 46))
            
        }

    }
}

//struct ProfileImageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileImageComponent(size: 44)
//    }
//}
