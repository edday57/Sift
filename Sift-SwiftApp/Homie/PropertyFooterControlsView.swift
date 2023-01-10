//
//  PropertyFooterControlsView.swift
//  Homeless
//
//  Created by Edward Day on 03/11/2022.
//

import SwiftUI

struct PropertyFooterControlsView: View {
    var body: some View {
        Rectangle().frame(width: .infinity, height: 120)
            .shadow(color: .white, radius: 5, x: 0, y: 0)
            .foregroundColor(.white)
            .overlay(alignment: .center) {
                HStack(alignment: .center, spacing: 70) {
                    ZStack{
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .shadow(color: .pink, radius: 8, x: 0, y: 0).opacity(0.5)
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60, alignment: .center)
                        Image(systemName: "cross.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.pink)
                            
                            .frame(width: 22, height: 22, alignment: .center)
                    }
                    ZStack{
                        Circle()
                            .frame(width: 80, height: 80, alignment: .center)
                            .shadow(color: .pink, radius: 10, x: 0, y: 5).opacity(0.5)
                        Circle()
                            .fill(.pink)
                            .frame(width: 80, height: 80, alignment: .center)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            
                            .frame(width: 30, height: 40, alignment: .center)
                    }
                    ZStack{
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .shadow(color: .blue, radius: 8, x: 0, y: 0).opacity(0.5)
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60, alignment: .center)
                        Image(systemName: "message.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("PrimaryBlue"))
                            
                            .frame(width: 22, height: 22, alignment: .center)
                    }
                }
            }
        
        
    }
        
}

struct PropertyFooterControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyFooterControlsView()
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
