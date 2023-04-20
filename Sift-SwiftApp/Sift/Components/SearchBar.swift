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
        VStack(spacing: 0){
            HStack {
                Image(systemName: "scope")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color("SecondaryText"))
                Text("in")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color("SecondaryText"))
                TextField("Enter Location", text: $searchTerm)
                    .foregroundColor(Color("PrimaryBlue"))
                    .font(.system(size: 16, weight: .bold))
                    .offset(x:-4, y: -1)
            }
            .padding(.bottom, 8)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color("SecondaryText").opacity(0.5))
        }
    }
}
//
//struct SearchBar_Previews: PreviewProvider {
//    let searchTerm = "london"
//    static var previews: some View {
//
//        let viewModel = PropertyModel()
//        viewModel.savedProperties=[propertyDemo, propertyDemo2]
//        viewModel.properties=[propertyDemo, propertyDemo2]
//        return HomeView2(showingMenu: .constant(false),selectedTab: .constant("Home"), viewModel: viewModel, user: userDemo)
//            
//    }
//}
