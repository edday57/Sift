//
//  NavBarComponent.swift
//  Articulate
//
//  Created by Edward Day on 01/12/2022.
//

import SwiftUI

struct NavBarComponent: View {
    var symbol=""
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
            Circle()
                .strokeBorder(Color("StrokeGrey"), lineWidth: 2)
                .frame(width: 44, height: 44)
                .foregroundColor(.white)
                .overlay(alignment: .center) {
                    Image(systemName: symbol)
                        .foregroundColor(Color("TextGreyDark"))
                        .frame(height: 16)
                }
        }
        
    }
}

struct NavBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavBarComponent(symbol: "chevron.left")
    }
}
