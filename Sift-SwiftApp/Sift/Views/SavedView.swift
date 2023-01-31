//
//  SavedView.swift
//  Sift
//
//  Created by Edward Day on 31/01/2023.
//

import SwiftUI

import SwiftUI

struct SavedView: View {
    @ObservedObject var viewModel = SavedViewModel()
    let user: User
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Text("Your Collection")
                        .font(.system(size: 24, weight: .bold))
                        .padding(20)
                    VStack(spacing: -25){
                        ForEach(Array(viewModel.savedProperties.prefix(5))){property in
                            NavigationLink{
                                ListingView(viewModel: PropertyCardModel(property: property, currentUser: user))
                            } label: {
                                CardListComponent(viewModel: PropertyCardModel(property: property, currentUser: user))
                            }
                            
                        }
                    }
                }
            }
            .refreshable {
                viewModel.getProperties()
            }
        }

       
        
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SavedViewModel()
        viewModel.savedProperties=[propertyDemo, propertyDemo2]
        return SavedView(viewModel: viewModel, user: userDemo)
    }
}
