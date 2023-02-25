//
//  MenuIcon.swift
//  Sift
//
//  Created by Edward Day on 25/02/2023.
//

import SwiftUI

struct MenuIcon: View {
    @State private var scale: CGFloat = 2
    var body: some View {
        Image(systemName: "list.bullet")
            .offset(x:-2, y: 2)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color("PrimaryText"))
            .overlay(alignment: .topTrailing) {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color("PrimaryBlue"))
                    //.offset(x: 2, y:-2)
            }
            .background(alignment: .topTrailing) {
                Circle()
                    .opacity(0.2)
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color("PrimaryBlue"))
                    //.offset(x: 2, y:-2)
                    .scaleEffect(scale, anchor: .center)
                                .animation(
                                    Animation.easeInOut(duration: 2)
                                       .repeatCount(5).delay(0), value: scale  // 2. << link to value
                                )
                                .onAppear {
                                    self.scale = 1    // 3. << withAnimation no needed now
                                }
            }
    }
}

struct MenuIcon_Previews: PreviewProvider {
    static var previews: some View {
        MenuIcon()
    }
}
