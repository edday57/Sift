//
//  ContentView.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State var showingAddPropertyView: Bool = false
    var body: some View {
        VStack {
            //MARK: - Header
            HeaderView(showingAddPropertyView: $showingAddPropertyView)
                
            Spacer()
            
            //MARK: - Card View
            CardView(property: propertyData[1])
                .padding()
            Spacer()
            PropertyFooterControlsView()
            //MARK: - Footer
            FooterView()
        }
        .sheet(isPresented: $showingAddPropertyView){
            AddPropertyFormView()
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
