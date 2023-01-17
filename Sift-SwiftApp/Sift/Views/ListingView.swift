//
//  ListingView.swift
//  Sift
//
//  Created by Edward Day on 06/12/2022.
//

import SwiftUI

struct ListingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let viewModel: PropertyCardModel
    var description = "No description added."

    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                
                        StickyHeader {
                            StickyHeader {
                                AsyncImage(url: URL(string: viewModel.property.images[0])){ image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    
                                }
                                    .overlay {
                                        LinearGradient(stops: [.init(color: .white.opacity(0.1), location: 0), .init(color: .white.opacity(0.1), location: 0.80), .init(color: .white.opacity(1.0), location: 1)], startPoint: .top, endPoint: .bottom)
                                    }
                                
                            }
                        }.overlay(alignment: .top) {
                            HStack(){
                                Button {
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    NavBarComponent(symbol: "chevron.left")
                                }
                                
                                Spacer()
                                Button {
                                    //
                                } label: {
                                    NavBarComponent(symbol: "heart")
                                }
                                Button {
                                    //
                                } label: {
                                    NavBarComponent(symbol: "ellipsis")
                                        .padding(.trailing)
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.bottom,20)
                            .offset(y: +25)
                        }
                        .offset(y: -35)
                         
                        HStack(alignment: .center) {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("StrokeGrey"))
                                    .frame(width: 50, height: 4, alignment: .center)
                                Text("2B | 3B")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                                    .background(Capsule()
                                        .foregroundColor(Color("PrimaryBlue")))
                                    .padding(.top)
                                Text(viewModel.property.address)
                                    .padding()
                                    .font(.system(size: 24, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    
                                HStack(alignment: .center){
                                    ProfileImageComponent(size: 30)
                                    Text("Ed Day")
                                        .foregroundColor(Color("TextGreyLight"))
                                    
                                        .font(.system(size: 14, weight: .medium))
                                    Circle()
                                        .frame(width: 2, height: 2, alignment: .center)
                                        .foregroundColor(Color("TextGreyLight"))
                                    Text("4 hours ago")
                                        .foregroundColor(Color("TextGreyLight"))
                                    
                                        .font(.system(size: 14))
                                }
                                Text(viewModel.property.description ?? "No details added.")
                                    .font(.system(size: 16))
                                    .padding(.top)
                             
                            }.padding(10)
                        }
                        .frame(maxWidth: .infinity, minHeight: 600, alignment: .top)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
                        .padding(.all, 10)
                        .offset(y: -100)
                         
                    
                }
        }
        .navigationBarHidden(true)
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(viewModel: PropertyCardModel(property: propertyDemo, currentUser: userDemo))
    }
}

struct StickyHeader<Content: View>: View {

    var minHeight: CGFloat
    var content: Content
    
    init(minHeight: CGFloat = 300, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            if(geo.frame(in: .global).minY <= 0) {
                content
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            } else {
                content
                    .offset(y: -geo.frame(in: .global).minY)
                    .frame(width: geo.size.width, height: geo.size.height + geo.frame(in: .global).minY)
            }
        }.frame(minHeight: minHeight)
    }
}
