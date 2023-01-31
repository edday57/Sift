//
//  UserView.swift
//  Sift
//
//  Created by Edward Day on 27/01/2023.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack{
            Text(viewModel.user?.name ?? "")
        }
        

    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserViewModel(userid: nil, user: userDemo)
        UserView(viewModel: viewModel)
    }
}
