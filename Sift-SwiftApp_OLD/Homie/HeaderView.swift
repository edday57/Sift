//
//  HeaderView.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showingAddPropertyView: Bool
    var body: some View {
        HStack {
            Button {
                print("Info")
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            Spacer()
            Text("header".uppercased())
                .font(.system(size: 28, weight: .heavy))
                //.foregroundColor(Color("PrimaryPurple"))
            Spacer()
            Button {
                self.showingAddPropertyView.toggle()
                
            } label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showAddPropertyView: Bool = false
    static var previews: some View {
        HeaderView(showingAddPropertyView: $showAddPropertyView)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
