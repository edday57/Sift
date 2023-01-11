//
//  ArticleView.swift
//  Articulate
//
//  Created by Edward Day on 06/12/2022.
//

import SwiftUI

struct ArticleView: View {
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                
                        StickyHeader {
                            StickyHeader {
                                Image("Article1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .overlay {
                                        LinearGradient(stops: [.init(color: .white.opacity(0.2), location: 0), .init(color: .white.opacity(0.2), location: 0.75), .init(color: .white.opacity(1.0), location: 1)], startPoint: .top, endPoint: .bottom)
                                    }
                                
                            }
                        }.overlay(alignment: .top) {
                            HStack(){
                                Button {
                                    //
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
                        }
                        .offset(y: -25)
                         
                        HStack(alignment: .center) {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("StrokeGrey"))
                                    .frame(width: 50, height: 4, alignment: .center)
                                Text("Tech | Fraud")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                                    .background(Capsule()
                                        .foregroundColor(Color("PrimaryBlue")))
                                    .padding(.top)
                                Text("Irish Arrests In Global Anti-Fraud Operation")
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
                                Text("Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..")
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
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
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
