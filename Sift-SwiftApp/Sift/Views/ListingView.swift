//
//  ListingView.swift
//  Sift
//
//  Created by Edward Day on 06/12/2022.
//

import SwiftUI
import Kingfisher
struct ListingView: View {
    @EnvironmentObject var likesModel: LikeModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let viewModel: PropertyCardModel
    var description = "No description added."
    @State var showingAgent = false
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
                                .offset(y: +40)
                            }
                    //MARK: Location Button
                            .overlay(alignment: .bottomTrailing) {
                                Button {
                                    //
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
                   
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 18){
                            HStack(spacing: 6){
                                Image(systemName: "bed.double")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("3")
                                    .foregroundColor(Color("PrimaryBlue"))
                                    .font(.system(size: 16, weight: .bold))
                                Text("Bedrooms")
                                    .foregroundColor(Color("PrimaryBlue"))
                                    .font(.system(size: 12, weight: .bold))
                                
                            }
                            .frame(height: 35)
                            .padding(.horizontal, 8)
                            .background{
                                Rectangle()
                                    .foregroundColor(Color("ListingTag"))
                                    .shadow(color: .black.opacity(0.1) ,radius: 5, y: 4)
                                    .border(Color("SecondaryTextLight"), width: 1)
                                    
                                    
                                    
                            }
                            HStack(spacing: 6){
                                Image(systemName: "shower")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("3")
                                    .foregroundColor(Color("PrimaryBlue"))
                                    .font(.system(size: 16, weight: .bold))
                                Text("Bathrooms")
                                    .foregroundColor(Color("PrimaryBlue"))
                                    .font(.system(size: 12, weight: .bold))
                                
                            }
                            .frame(height: 35)
                            .padding(.horizontal, 8)
                            .background{
                                Rectangle()
                                    .foregroundColor(Color("ListingTag"))
                                    .shadow(color: .black.opacity(0.1) ,radius: 5, y: 4)
                                    .border(Color("SecondaryTextLight"), width: 1)
                                    
                                    
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        
                    
                    
                    }
                    .padding(.vertical, -10)
                }
                
                Text(viewModel.property.description ?? "No description found.")
                    .padding(.horizontal, 20)
                    .foregroundColor(Color("SecondaryText"))
                    .font(.system(size: 14, weight: .medium))
                
                       
                         
                    
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
                        Text("£10,000 pcm")
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

struct ListingView2: View {
    @EnvironmentObject var likesModel: LikeModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let viewModel: PropertyCardModel
    var description = "No description added."
    @State var showingAgent = false
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
                                AsyncButton {
                                    await likesModel.AtoggleLike(listingID: viewModel.property.id)
                                } label: {
                                    if likesModel.likedPosts.contains(viewModel.property.id){
                                        NavBarComponent(symbol: "heart.fill")
                                    }
                                    else{
                                        NavBarComponent(symbol: "heart")
                                    }
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
                                    ProfileImageComponent(size: 30, image: viewModel.agent?.image ?? "")
                                    Text(viewModel.agent?.name ?? "")
                                        .foregroundColor(Color("TextGreyLight"))
                                    
                                        .font(.system(size: 14, weight: .medium))
                                    Circle()
                                        .frame(width: 2, height: 2, alignment: .center)
                                        .foregroundColor(Color("TextGreyLight"))
                                    Text("4 hours ago")
                                        .foregroundColor(Color("TextGreyLight"))
                                    
                                        .font(.system(size: 14))
                                }
                                .onTapGesture {
                                    showingAgent.toggle()
                                }
                                .fullScreenCover(isPresented: $showingAgent){
                                    AgentView(viewModel: AgentViewModel(agent: viewModel.agent!))
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
        ListingView(viewModel: PropertyCardModel(property: propertyDemo, currentUser: userDemo, agent: agentDemo))
            .environmentObject(LikeModel(currentUser: userDemo))
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
