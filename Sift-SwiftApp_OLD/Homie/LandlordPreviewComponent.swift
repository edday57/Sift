//
//  LandlordPreviewComponent.swift
//  Homeless
//
//  Created by Edward Day on 03/11/2022.
//

import SwiftUI

struct LandlordPreviewComponent: View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(20)
                .frame(height: 100, alignment: .center)
            .foregroundColor(Color("SecondaryGrey"))
            HStack{
                Image("Tate")
                    .resizable()
                    .cornerRadius(30)
                    .frame(maxWidth:60, maxHeight: 60)
                    .padding()
                //Spacer()
                VStack(alignment: .leading){
                    HStack(alignment: .center, spacing: 2){
                        Text("Andrew")
                            .padding(.horizontal, 5)
                            .font(Font.custom("Gilroy-Bold", size: 18))
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:14, height: 14)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:14, height: 14)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:14, height: 14)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:14, height: 14)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:14, height: 14)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:14, height: 14)
                    }
                    Button {
                        print("Click")
                    } label: {
                        Text("See More")
                            .underline()
                            .padding(.horizontal, 5)
                            .foregroundColor(Color.pink)
                    }

                }.frame(maxWidth: .infinity)
                    
            }
        }
    }
}

struct LandlordPreviewComponent_Previews: PreviewProvider {
    static var previews: some View {
        LandlordPreviewComponent()
    }
}
