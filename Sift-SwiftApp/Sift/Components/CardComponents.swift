//
//  CardLargeComponent.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI
import Kingfisher

struct CardLargeComponent: View {
    @ObservedObject var viewModel: PropertyCardModel
    
    init(viewModel: PropertyCardModel){
        self.viewModel = viewModel
    }
    var body: some View {
        let formattedPrice = String(format: "£%.0f pcm", viewModel.property.price)
        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 290, height: 320)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1),radius: 5)
            
            VStack(alignment: .center){
                
                KFImage(URL(string: viewModel.property.images[0]))
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 276, height: 165)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(7)
                    .shadow(color: .black.opacity(0.1), radius: 10, y:4)
                    .overlay{
                        
                        HStack(spacing:0){
                            Text("\(viewModel.property.bedrooms) ")
                            Image(systemName: "bed.double.fill").font(.system(size: 12))
                            Divider().frame(width: 1.3, height:16)
                                .background(Color.white).padding(3)
                            Text("\(viewModel.property.bathrooms) ")
                            Image(systemName: "shower.fill").font(.system(size: 12))
                        }
                        
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .background{
                                Capsule()
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .position(x:60, y:27)
                    }
                    
                HStack{
                    Text(formattedPrice)
                        .foregroundColor(Color("TextGreyLight"))
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Text("Listed \(viewModel.property.date_added.formatDate())")
                        .foregroundColor(Color("TextGreyLight"))
                    
                        .font(.system(size: 14, weight: .medium))
                }
                .frame(width: 270)
                .padding(.top, 6)
                
                Text("\(viewModel.property.address)")
                    .lineLimit(2)
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 270, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top, 2)
                    .foregroundColor(.black)
                Spacer()
                HStack{
                    if let agent = viewModel.agent{
                        ProfileImageComponent(size: 30, image: agent.image!)
                        Text(agent.name)
                            .foregroundColor(Color("TextGreyLight"))
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 14, weight: .medium))
                    }
                    Spacer()
                    Text("...")
                        .foregroundColor(Color("TextGreyLight"))
                    
                        .font(.system(size: 14))
                }
                .frame(width: 262)
                .padding(.bottom, 12)
                //Spacer()
            }
        }
    }
}

struct CardLargeComponentNew: View {
    @ObservedObject var viewModel: PropertyCardModel
    
    init(viewModel: PropertyCardModel){
        self.viewModel = viewModel
    }
    var body: some View {
        let formattedPrice = String(format: "£%.0f pcm", viewModel.property.price)
    
        VStack(alignment: .center){
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .frame(width: 254, height: 164)
                    .shadow(color: .black.opacity(0.1), radius: 2, y:4)
                KFImage(URL(string: viewModel.property.images[0]))
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(7)
                    .overlay{
                        
                        HStack(spacing:0){
                            Text("\(viewModel.property.bedrooms) ")
                                .font(.system(size: 12, weight: .heavy))
                            Image(systemName: "bed.double.fill").font(.system(size: 12))
                            Divider().frame(width: 1.4, height:12)
                                .background(Color.white).padding(3)
                            Text("\(viewModel.property.bathrooms) ")
                                .font(.system(size: 12, weight: .heavy))
                            Image(systemName: "shower.fill").font(.system(size: 12))
                        }
                        .foregroundColor(.white)
                        
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background{
                            Capsule()
                                .foregroundColor(Color.black)
                                .opacity(0.55)
                        }
                        .position(x:60, y:27)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            //
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 28, height: 28)
                                    .shadow(color: .black
                                        .opacity(0.2), radius: 5, y:4)
                                Image(systemName: "location.fill")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color("PrimaryBlue"))
                                    
                                    
                            }
                            .offset(x: -16, y: -14)
                                
                        }

                    }
            }

            HStack{
                Text(formattedPrice)
                    .foregroundColor(Color("PrimaryBlue"))
                    .font(.system(size: 14, weight: .bold))
                Spacer()
                Text("Listed \(viewModel.property.date_added.formatDate())")
                    .foregroundColor(Color("SecondaryText"))
                
                    .font(.system(size: 12, weight: .semibold))
            }
            .frame(width: 254)
            .padding(.bottom, 1)
            
            Text("\(viewModel.property.address)")
                .lineLimit(1)
                .font(.system(size: 16, weight: .black))
                .foregroundColor(Color("PrimaryText"))
                .frame(width: 254, alignment: .leading)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .foregroundColor(.black)
            Spacer()
            HStack{
                if let agent = viewModel.agent{
                    Text(agent.name)
                        .foregroundColor(Color("SecondaryText"))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14, weight: .medium))
                }
                Spacer()
                
            }
            .frame(width: 254)
            //Spacer()
        }
        
    }
}

struct CardListComponent: View {
    @ObservedObject var viewModel: PropertyCardModel
    
    init(viewModel: PropertyCardModel){
        self.viewModel = viewModel
    }
    var body: some View {
        let formattedPrice = String(format: "£%.0f pcm", viewModel.property.price)
        let bedbath = String(format: "%iB | %iB", viewModel.property.bedrooms, viewModel.property.bathrooms)
        HStack{
            VStack(alignment: .leading){
                HStack {
                    Text(formattedPrice)
                        .foregroundColor(Color("TextGreyLight"))
                        .font(.system(size: 12, weight: .medium))
                    Spacer()
                    Text(bedbath)
                        .foregroundColor(Color("TextGreyLight"))
                        .font(.system(size: 12, weight: .medium))
                }
                Spacer()
                Text(viewModel.property.address).bold()
                    .lineLimit(2)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack{
                    if let agent = viewModel.agent{
                        ProfileImageComponent(size: 30, image: agent.image!)
                        Text(agent.name)
                            .foregroundColor(Color("TextGreyLight"))
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 12, weight: .medium))
                    }
                    Spacer()
//                    Text("...")
//                        .foregroundColor(Color("TextGreyLight"))
//
//                        .font(.system(size: 14))
                }
                //.frame(width: 262)
                //.padding(.bottom, 12)
            }
            .padding(12)
            Spacer()
            KFImage(URL(string: viewModel.property.images[0]))
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .frame(width: 135, height: 125)
                .clipShape(RoundedRectangle(cornerRadius: 19))
                .padding(4)
                .shadow(color: .black.opacity(0.1), radius: 10, y:4)
        }
        .background(Color(.white))
        .cornerRadius(20)
        .padding(20)
        .shadow(color: .black.opacity(0.1),radius: 5)
        
    }
}

struct CardDiscoverComponentNew: View {
    @ObservedObject var viewModel: PropertyCardModel
    
    init(viewModel: PropertyCardModel){
        self.viewModel = viewModel
    }
    var body: some View {
        let formattedPrice = String(format: "£%.0f pcm", viewModel.property.price)
        let bedbath = String(format: "%i Beds | %i Baths", viewModel.property.bedrooms, viewModel.property.bathrooms)
            VStack(alignment: .center){
                KFImage(URL(string: viewModel.property.images[0]))
                    .resizable()
                    .scaledToFill()
                .frame(height: 165)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.1), radius: 10, y:4)
                .overlay{
                    Text("3.7km away")
                        .font(.system(size: 12, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .background{
                        Capsule()
                            .foregroundColor(Color.black)
                            .opacity(0.55)
                    }
                    .position(x:60, y:27)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.white, lineWidth: 3)
                }
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        //
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .shadow(color: .black
                                    .opacity(0.2), radius: 5, y:4)
                            Image(systemName: "location.fill")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color("PrimaryBlue"))
                                
                                
                        }
                        .offset(x: -20, y: 14)
                            
                    }

                }
                .padding(.bottom, 8)
                
                
                Text("\(viewModel.property.address)")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(Color("PrimaryText"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                HStack{
                    if let agent = viewModel.agent{
                        Text(agent.name)
                            .foregroundColor(Color("SecondaryText"))
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 14, weight: .medium))
                    }
                    Spacer()
                    Text(formattedPrice)
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 14, weight: .bold))
                }
                .padding(.bottom, 1)
                HStack(){
                    Text(bedbath)
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 12, weight: .heavy))
                        .padding(7)
                        .background{
                            Color("SecondaryBlue")
                                .cornerRadius(4)
                        }
                    Spacer()
                    
                }
                
            }
            .padding(.horizontal, 24)
        
        
        
    }
}

struct CardDiscoverComponent: View {
    @ObservedObject var viewModel: PropertyCardModel
    
    init(viewModel: PropertyCardModel){
        self.viewModel = viewModel
    }
    var body: some View {
        let formattedPrice = String(format: "£%.0f pcm", viewModel.property.price)
        let bedbath = String(format: "%iB | %iB", viewModel.property.bedrooms, viewModel.property.bathrooms)
        
            
            GeometryReader { geo in
                VStack(alignment: .leading){
                    //Image
                    KFImage(URL(string: viewModel.property.images[0]))
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width-44,height: 270)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .padding(6)
                        .shadow(color: .black.opacity(0.1), radius: 10, y:4)
                    
                    
                    //Address
                    Text("\(viewModel.property.address)")
                        .lineLimit(2)
                        .font(.system(size: 18, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 2)
                        .foregroundColor(.black)
                    HStack{
                        FilterButtonComponent(label: formattedPrice, image: "dollarsign")
                        Spacer()
                        FilterButtonComponent(label: String(viewModel.property.bedrooms), image: "bed.double.fill")
                        Spacer()
                        FilterButtonComponent(label: String(viewModel.property.bathrooms), image: "shower.fill")
                        Spacer()
                        FilterButtonComponent(label: "", image: "mappin")
                    }
                    .padding(.horizontal, 20)
                    Text(viewModel.property.description ?? "No details added.")
                        .font(.system(size: 16))
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    HStack{
                        ProfileImageComponent(size: 30, image: viewModel.agent?.image ?? "")
                        Text(viewModel.agent?.name ?? "")
                            .foregroundColor(Color("TextGreyLight"))
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 14, weight: .medium))
                        Spacer()
                        Text("Listed \(viewModel.property.date_added.formatDate())")
                            .foregroundColor(Color("TextGreyLight"))
                        
                            .font(.system(size: 14))
                    }
                    .padding(20)
                    //Spacer()
                        //.layoutPriority(1)
                }
                .background(Color(.white))
                .cornerRadius(30)
                //.padding(.bottom, 20)
                .padding(.horizontal, 16)
                .shadow(color: .black.opacity(0.1),radius: 5)
                .frame(height: 570)
            }
 
            
        
        
        
        
    }
}

struct CardFullWidthListComponent: View {
    @ObservedObject var viewModel: PropertyCardModel
    
    init(viewModel: PropertyCardModel){
        self.viewModel = viewModel
    }
    var body: some View {
        let formattedPrice = String(format: "£%.0f pcm", viewModel.property.price)
        VStack(alignment: .leading){
            KFImage(URL(string: viewModel.property.images[0]))
                .resizable()
                .scaledToFill()
            .frame(height: 165)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.1), radius: 10, y:4)
            .overlay{
                
                HStack(spacing:0){
                    Text("\(viewModel.property.bedrooms) ")
                    Image(systemName: "bed.double.fill").font(.system(size: 12))
                    Divider().frame(width: 1.3, height:16)
                        .background(Color.white).padding(3)
                    Text("\(viewModel.property.bathrooms) ")
                    Image(systemName: "shower.fill").font(.system(size: 12))
                }
                
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .background{
                        Capsule()
                            .foregroundColor(Color("PrimaryBlue"))
                    }
                    .position(x:60, y:27)
            }
            
            HStack{
                Text(formattedPrice)
                    .foregroundColor(Color("TextGreyLight"))
                    .font(.system(size: 14, weight: .medium))
                Spacer()
                Text("Listed \(viewModel.property.date_added.formatDate())")
                    .foregroundColor(Color("TextGreyLight"))
                
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.vertical, 6)
            Text("\(viewModel.property.address)")
                .lineLimit(1)
                .font(.system(size: 18, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
            HStack{

                if let agent = viewModel.agent{
                    ProfileImageComponent(size: 30, image: agent.image!)
                    Text(agent.name)
                        .foregroundColor(Color("TextGreyLight"))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14, weight: .medium))
                }
                
                Spacer()
                Text("...")
                    .foregroundColor(Color("TextGreyLight"))
                
                    .font(.system(size: 14))
            }
            .padding(.bottom, 12)
        }
        .padding(7)
        .background{
        RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1),radius: 5)
        }
        
 
            
        
        
        
        
    }
}

struct CardLargeComponent_Previews: PreviewProvider {
    static var previews: some View {
        CardFullWidthListComponent(viewModel: PropertyCardModel(property: propertyDemo, currentUser: userDemo))
            .padding(20)
    }
}

extension Date {
        func formatDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("d MM yy")
            return dateFormatter.string(from: self)
        }
}
