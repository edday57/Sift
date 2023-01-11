//
//  FooterView.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack {
            Button {
                print("Dislike")
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 42, weight: .regular))
            }
            .accentColor(Color.primary)
            Spacer()
            Text("Contact Landlord".uppercased())
                .font(Font.custom("Gilroy-Heavy", size: 18))
                .foregroundColor(Color("PrimaryBlue"))
                .padding(10)
                .background(
                    Capsule().stroke(Color("PrimaryBlue"), lineWidth: 3)
                        .foregroundColor(Color.white))
                
                //.foregroundColor(Color("PrimaryPurple"))
            Spacer()
            Button {
                print("Like")
            } label: {
                Image(systemName: "heart.circle")
                    .font(.system(size: 42, weight: .regular))
            }
            .accentColor(Color.primary)
            
        }
        .padding()
    }
    
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
