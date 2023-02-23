//
//  ListingView.swift
//  Sift
//
//  Created by Edward Day on 06/12/2022.
//

import SwiftUI
import Kingfisher
import MapKit
struct ListingView: View {
    @EnvironmentObject var likesModel: LikeModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let viewModel: PropertyCardModel
    var description = "No description added."
    @State var showingAgent = false
    @State var showingMap = false
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    ImageSlider(images: viewModel.property.images)
                        .frame(height: 300)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                        .shadow(radius: 5, y:4)
                            .overlay(alignment: .top) {
                                HStack(spacing: 14){
                                    Button {
                                        self.presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(systemName: "arrow.left")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .semibold))
                                            .shadow(color: .black.opacity(1),radius: 5)
                                    }
                                    
                                    Spacer()
                                    AsyncButton {
                                        await likesModel.AtoggleLike(listingID: viewModel.property.id)
                                    } label: {
                                        ZStack{
                                            if likesModel.likedPosts.contains(viewModel.property.id){
                                                Image(systemName: "heart.fill")
                                                    .foregroundColor(.red)
                                                    .font(.system(size: 20, weight: .semibold))
                                                    .shadow(color: .black.opacity(0.7),radius: 5)
                                            }
                                            Image(systemName: "heart")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20, weight: .semibold))
                                                .shadow(color: .black.opacity(likesModel.likedPosts.contains(viewModel.property.id) ? 0:0.7),radius: 5)
                                        }
                                        
                                    }
                                    Button {
                                        //
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .semibold))
                                            .shadow(color: .black.opacity(0.7),radius: 5)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom,20)
                                .offset(y: +50)
                            }
                    //MARK: Location Button
                            .overlay(alignment: .bottomTrailing) {
                                Button {
                                    
                                    showingMap = true

                                } label: {
                                    ZStack{
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(width: 46, height: 46)
                                            .shadow(color: .black
                                                .opacity(0.2), radius: 5, y:4)
                                        Image(systemName: "location.fill")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color("PrimaryBlue"))
                                            
                                            
                                    }
                                    .offset(x: -23, y: 23)
                                        
                                }
                                

                            }
                            .sheet(isPresented: $showingMap ) {
                                
                                
                                    MapView(latitude: Double(viewModel.property.latitude), longitude: Double(viewModel.property.longitude), isPresented: $showingMap)
                                    .presentationDetents([.medium])
                                
                            }
                    
                    //MARK: Address
                    Text(viewModel.property.address)
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        .font(.system(size: 16, weight: .black))
                        .foregroundColor(Color("PrimaryText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    
                    //MARK: Agent Name
                    if let agent = viewModel.agent{
                        HStack{
                            KFImage(URL(string: agent.image ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                                
                            Text(agent.name)
                                .foregroundColor(Color("SecondaryText"))
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                    }
                    
                    //MARK: Rating
                    HStack(alignment: .center){
                        RatingBar(rating: 0.85)
                            .frame(width: 130)
                            .padding(.top, 4)
                            .padding(.trailing, 4)
                        Text("85% match")
                            .font(.system(size: 14, weight: .heavy))
                            .foregroundColor(Color("PrimaryBlue"))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                   
                    ListingTags(beds: viewModel.property.bedrooms, baths: viewModel.property.bathrooms, sqft: viewModel.property.sizesqft)
                    .padding(.vertical, -10)
                    
                    Text(viewModel.property.description ?? "No description found.")
                        .padding(.horizontal, 20)
                        .foregroundColor(Color("SecondaryText"))
                        .font(.system(size: 14, weight: .medium))
                }
                
                
                
                       
                         
                    
                }
            .padding(.bottom, 80)
            .overlay(alignment: .bottom){
                HStack(spacing: 0){
                    ZStack{
                        Rectangle()
                            
                            .frame(height: 70)
                            .foregroundColor(Color("PrimaryBlue"))
                            .overlay(alignment: .trailing) {
                                Triangle()
                                    .frame(width: 20)
                                    .foregroundColor(.white)
                            }
                        Text(viewModel.formattedPrice)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .heavy))
                    }
                    ZStack{
                        Rectangle()
                            .frame(height: 70)
                            .foregroundColor(.white)
                        Text("Contact Agent")
                            .foregroundColor(Color("PrimaryBlue"))
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                    
                }
                .background{
                    Color.white
                        .shadow(radius: 5)
                }
                
            }
            .ignoresSafeArea()
            
            
        }
        .navigationBarHidden(true)
        
    }
}
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}



struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(viewModel: PropertyCardModel(property: propertyDemo, currentUser: userDemo, agent: agentDemo))
            .environmentObject(LikeModel(currentUser: userDemo))
    }
}


