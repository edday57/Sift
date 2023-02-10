//
//  SearchBar.swift
//  Sift
//
//  Created by Edward Day on 09/02/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchTerm: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("StrokeGrey"), lineWidth: 2)
                .frame(height: 42)
                .foregroundColor(.white)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("TextGreyLight"))
                        TextField("Search", text: $searchTerm)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 10)
                }
                .padding(.leading,20)
                .padding(.trailing,20)
        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
