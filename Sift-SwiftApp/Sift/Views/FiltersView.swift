//
//  FiltersView.swift
//  Sift
//
//  Created by Edward Day on 01/02/2023.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) var dismiss
    @State var priceSliderPosition: ClosedRange<Float> = 100...16000
    @State var sizeSliderPosition: ClosedRange<Float> = 0...300
    var body: some View {
        ScrollView {
            VStack {
                //Top Bar
                HStack{
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundColor(Color("TextGreyDark"))
                    })
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Filters")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button {
                        print("hi")
                    } label: {
                        Text("Reset")
                            .foregroundColor(.white)
                            .padding(11)
                            .background(RoundedRectangle(cornerRadius: 11)
                                .cornerRadius(13)
                                .foregroundColor(Color("PrimaryBlue")))
                                .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 2)
                                .font(.system(size: 14, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(20)
                
                Text("Property Type")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .font(.system(size: 24, weight: .bold))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20){
                        Button {
                            //
                        } label: {
                            Text("Any")
                                .filterStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("Apartment")
                                .filterSelectedStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("Town House")
                                .filterStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("Whole Home")
                                .filterStyle()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Divider()
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                Group{
                    HStack {
                        Text("Price Per Month")
                            .padding(20)
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(1)
                        Spacer()
                        Text("£\(String(format: "%0.f", priceSliderPosition.lowerBound)) - £\(String(format: "%0.f", priceSliderPosition.upperBound))")
                            .padding(20)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color("PrimaryBlue"))
                    }
                    RangedSliderView(value: $priceSliderPosition, bounds: 100...17000)
                        .padding(.horizontal, 30)
                }

                Divider()
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                
                Group{
                    Text("Bedrooms")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .font(.system(size: 24, weight: .bold))
                    HStack(spacing: 20){
                        
                        Group {
                            Button {
                                //
                            } label: {
                                Text("Any")
                                    .filterStyle()
                            }
                            Button {
                                //
                            } label: {
                                Text("1")
                                    
                                    .filterStyle()
                            }
                            Button {
                                //
                            } label: {
                                Text("2")
                                    .filterStyle()
                            }
                            Button {
                                //
                            } label: {
                                Text("3")
                                    .filterStyle()
                            }
                            Button {
                                //
                            } label: {
                                Text("4+")
                                    .filterStyle()
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Divider()
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                
                Group{
                    Text("Bathrooms")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .font(.system(size: 24, weight: .bold))
                    HStack(spacing:20){
                        Button {
                            //
                        } label: {
                            Text("Any")
                                .filterStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("1")
                                
                                .filterStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("2")
                                .filterSelectedStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("3")
                                .filterSelectedStyle()
                        }
                        Button {
                            //
                        } label: {
                            Text("4+")
                                .filterStyle()
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }

                Group{
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                    HStack {
                        Text("Property Size (sqft)")
                            .padding(20)
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(1)
                        Spacer()
                        Text("\(String(format: "%0.f", sizeSliderPosition.lowerBound)) - \(String(format: "%0.f", sizeSliderPosition.upperBound))")
                            .padding(20)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color("PrimaryBlue"))
                    }
                    RangedSliderView(value: $sizeSliderPosition, bounds: 0...300)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                }


                

                
            }
        }
    }
}

extension Text {
    func filterSelectedStyle() -> some View {
        self.foregroundColor(.white)
            .padding(14)
            .font(.system(size: 14, weight: .bold))
            .background(RoundedRectangle(cornerRadius: 11)
                .cornerRadius(13)
                .foregroundColor(Color("PrimaryBlue")))
                .shadow(color: Color("PrimaryBlue").opacity(0.7),radius: 2)
                
    }
    
    func filterStyle() -> some View {
        self.foregroundColor(Color("TextGreyDark"))
            .padding(14)
            .font(.system(size: 14, weight: .bold))
            .background(
                RoundedRectangle(cornerRadius: 11)
                    .strokeBorder(Color("StrokeGrey"), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 11)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.05), radius: 3)
                    )
            )
                
    }
}


struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        return FiltersView()
    }
}
