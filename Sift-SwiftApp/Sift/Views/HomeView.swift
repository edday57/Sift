//
//  HomeView.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var propertyModel = PropertyModel()
    var body: some View {
        
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                    
                    VStack(alignment: .center, spacing: 8) {
                        //Nav
                        HStack(){
                            Button {
                                //
                            } label: {
                                NavBarComponent(symbol: "list.bullet")
                            }
                            
                            Spacer()
                            Button {
                                //
                            } label: {
                                NavBarComponent(symbol: "magnifyingglass")
                            }
                            Button {
                                //
                            } label: {
                                ProfileImageComponent(size: 44)
                                    .padding(.trailing, 20)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.bottom,20)
                        
                        //Top Buttons
                        HStack(alignment: .center) {
                            Text("All")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(5)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                .background(Capsule()
                                    .foregroundColor(Color("PrimaryBlue")))
                            Spacer()
                            Text("For You")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                .background(Capsule()
                                    .foregroundColor(Color("StrokeGrey")))
                            Spacer()
                            Text("Trending")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                .background(Capsule()
                                    .foregroundColor(Color("StrokeGrey")))
                            Spacer()
                            Text("Following")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.leading, 6)
                                .padding(.trailing, 6)
                                .background(Capsule()
                                    .foregroundColor(Color("StrokeGrey")))

                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 0)
                        
                        //For You Section
                        HStack {
                            Text("For You")
                                .font(.system(size: 24, weight: .bold))
                                .padding(20)
                            Spacer()
                            Button {
                                //for you
                            } label: {
                                Text("See More")
                                    .underline()
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(20)
                                    .foregroundColor(Color("TextGreyLight"))
                            }
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 16){
                                CardLargeComponent()
                                 CardLargeComponent()
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                           
                            
                        }
                        HStack {
                            Text("Following")
                                .font(.system(size: 24, weight: .bold))
                                .padding(20)
                            Spacer()
                            Button {
                                //for you
                            } label: {
                                Text(propertyModel.properties[0].address)
                                    .underline()
                                    .font(.system(size: 14))
                                    .padding(20)
                                    .foregroundColor(Color("TextGreyLight"))
                            }
                        }

                        

                        Image("UImockup")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 46))
                            .padding(20)
                            .shadow(color: .black.opacity(0.07), radius: 6, y:4)
                        Spacer()
                            
                    }
                
            }
        }
        .onAppear{
            propertyModel.getProperties()
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
