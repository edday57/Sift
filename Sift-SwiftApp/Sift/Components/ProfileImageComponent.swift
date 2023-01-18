//
//  ProfileImageComponent.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI

struct ProfileImageComponent: View {
    var size = 0.0
    var image = "Profile1"
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size, alignment: .center)
                .foregroundColor(Color("StrokeGrey"))
            if(self.image==""){
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size-2, height: size-2)
                    .clipShape(RoundedRectangle(cornerRadius: 46))
                    .foregroundColor(.white)
            }
            else{
                AsyncImage(url: URL(string: image)){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    
                }
                .frame(width: size-2, height: size-2)
                .clipShape(RoundedRectangle(cornerRadius: 46))
            }
        }

    }
}

struct ProfileImageComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageComponent(size: 44)
    }
}
