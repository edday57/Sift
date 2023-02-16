//
//  AgentView.swift
//  Sift
//
//  Created by Edward Day on 15/02/2023.
//

import SwiftUI

struct AgentView: View {
    @ObservedObject var viewModel: AgentViewModel
    var body: some View {
        VStack{
            Text(viewModel.agent.name)
            ForEach(viewModel.properties){ property in
                Text(property.address)
            }}

    }
}

//struct AgentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AgentView()
//    }
//}
