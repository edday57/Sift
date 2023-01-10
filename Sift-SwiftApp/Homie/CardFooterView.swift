//
//  CardFooterView.swift
//  Homeless
//
//  Created by Edward Day on 03/11/2022.
//

import SwiftUI

struct CardFooterView: View {
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0){
                    Image("placeholderProperty1")
                        .resizable()
                        .cornerRadius(30)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                        .shadow(radius: 5)
                        .padding(20)
                    VStack(alignment: .leading) {

                        HStack {
                            VStack(alignment: .leading, spacing: 5){
                                Text("213 Ivy Grove")
                                    .font(Font.custom("Gilroy-Extrabold", size: 24))
                                Text("Darlington, DL2 2JZ")
                                    .foregroundColor(.secondary)
                        }
                            Spacer()
                            Text("2100 pw")
                                .padding()
                                .background(Capsule()
                                    .foregroundColor(Color("SecondaryGrey")))
                                .padding()
                                
                        }
                        Text("Short description about property here. This should be a couple of lines of bullshit.")
                        Divider().padding(.vertical, 20)
                        LandlordPreviewComponent()

                    }.padding(30)
                }
            }
            PropertyFooterControlsView()
                .padding(.bottom, 20)

        }


    }
}

struct CardFooterView_Previews: PreviewProvider {
    static var previews: some View {
        CardFooterView()
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
