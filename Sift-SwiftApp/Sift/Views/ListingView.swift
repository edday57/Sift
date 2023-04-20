//
//  ListingView.swift
//  Sift
//
//  Created by Edward Day on 06/12/2022.
//

import SwiftUI
import Kingfisher
import MapKit
import CoreData
struct ListingView: View {
    @EnvironmentObject var likesModel: LikeModel
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let viewModel: PropertyCardModel
    var description = "No description added."
    @State var showingAgent = false
    @State var showingMap = false
    @State private var startTime: Date?
    @State var didScroll = false
    @State var viewedImg = 1
    @State var timer: Timer = Timer()
    @FetchRequest(sortDescriptors: []) var ratings: FetchedResults<ImplicitRating>
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
                                            .shadow(color: Color("ShadowBlue")
                                                .opacity(0.3), radius: 5, y:4)
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
                        if let score = viewModel.property.matchscore{
                            //score = score/5
                            RatingBar(rating: Double(score)/5)
                                .frame(width: 130)
                                .padding(.top, 4)
                                .padding(.trailing, 4)
                            Text("\(Int(score*20))% match")
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundColor(Color("PrimaryBlue"))
                        }
                        else {
                            RatingBar(rating: 0.8)
                                .frame(width: 130)
                                .padding(.top, 4)
                                .padding(.trailing, 4).frame(maxWidth: 120, maxHeight: 10)
                            Text("80% match")
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundColor(Color("PrimaryBlue"))
                        }
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
        .onAppear{
            startTime = Date()
        }
        .onDisappear {
                    // Stop timing when the user stops viewing the property
            if let startTime = startTime {
                let duration = Date().timeIntervalSince(startTime)
                print("Time spent in view: \(duration) seconds")
                let rating = calculateRating(timeSpent: duration, didScroll: didScroll, viewedImg: viewedImg)
                trackEvent(name: "property_view", properties: ["rating": String(rating), "listingId": viewModel.property.id])
            }
        }
                    // Calculate the implicit rating based on time spent and liked status
                    
                    // Record the implicit rating as an event
                    //trackEvent(name: "property_view", properties: ["rating": rating])
        
        
    }
    
    func calculateRating(timeSpent: TimeInterval, didScroll: Bool, viewedImg: Int) -> Int {
            // Calculate an implicit rating based on the time spent and liked status
        var isLiked = false
        if likesModel.likedPosts.contains(viewModel.property.id){
            isLiked = true
        }
        var existingRating: Int = 0
        self.ratings.forEach { rating in
            if rating.listingId == viewModel.property.id {
                existingRating = Int(rating.rating!) ?? 0
            }
        }
        
        var rating = 1
            if isLiked {
                rating = 5
            } else if timeSpent >= 30 && didScroll {
                rating = 4
            } else if timeSpent >= 15 && didScroll {
                rating = 3
            } else if existingRating != 0 {
                rating = 3
            }else if timeSpent >= 7 {
                rating = 2
            }
        if rating > existingRating{
            return rating
        }
        return 0
    }
    
    func trackEvent(name: String, properties: [String: Any]) {
        if properties["rating"] as! String  == "0" {
            return
        }
        self.ratings.forEach { rating in
            if rating.listingId == viewModel.property.id {
                print(rating.rating!)
                
                rating.rating = (properties["rating"] as! String)
                try? moc.save()
                return
            }
        }
        print(properties["rating"]!)
        let rating = ImplicitRating(context: moc)
        rating.listingId = (properties["listingId"] as! String)
        rating.rating = (properties["rating"] as! String)
        try? moc.save()
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


