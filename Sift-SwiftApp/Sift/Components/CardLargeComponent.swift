//
//  CardLargeComponent.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI

struct CardLargeComponent: View {
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 290, height: 320)
                .foregroundColor(.white)
            VStack(alignment: .center){
                Image("UImockup")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 276, height: 165)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(7)
                    .shadow(color: .black.opacity(0.1), radius: 10, y:4)
                HStack{
                    Text("£1,300 pcm")
                        .foregroundColor(Color("TextGreyLight"))
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Text("Listed 20/01/23")
                        .foregroundColor(Color("TextGreyLight"))
                    
                        .font(.system(size: 14, weight: .medium))
                }
                .frame(width: 270)
                .padding(.top, 6)
                
                Text("Hanover Terrace Regents Park NW1")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 270, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top, 2)
                Spacer()
                HStack{
                    ProfileImageComponent(size: 30)
                    Text("Hamptons Lettings")
                        .foregroundColor(Color("TextGreyLight"))
                    
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Text("...")
                        .foregroundColor(Color("TextGreyLight"))
                    
                        .font(.system(size: 14))
                }
                .frame(width: 262)
                .padding(.bottom, 12)
                //Spacer()
            }
        }
    }
}

struct CardLargeComponent_Previews: PreviewProvider {
    static var previews: some View {
        CardLargeComponent()
    }
}
