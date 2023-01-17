//
//  CardLargeComponent.swift
//  Articulate
//
//  Created by Edward Day on 04/12/2022.
//

import SwiftUI

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
                
                AsyncImage(url: URL(string: viewModel.property.images[0])){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    
                }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 276, height: 165)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(7)
                    .shadow(color: .black.opacity(0.1), radius: 10, y:4)
                HStack{
                    Text(formattedPrice)
                        .foregroundColor(Color("TextGreyLight"))
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Text("Listed \(viewModel.property.date_added)")
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
                    ProfileImageComponent(size: 30)
                    Text("Hamptons Lettings")
                        .foregroundColor(Color("TextGreyLight"))
                    
                        .font(.system(size: 14, weight: .medium))
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
                    ProfileImageComponent(size: 30)
                    Text("Hamptons Lettings")
                        .foregroundColor(Color("TextGreyLight"))
                        .font(.system(size: 12, weight: .medium))
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
            AsyncImage(url: URL(string: viewModel.property.images[0])){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                
            }
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
                    AsyncImage(url: URL(string: viewModel.property.images[0])){ image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        
                    }
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
                    HStack{
                        ProfileImageComponent(size: 30)
                        Text("Chestertons")
                            .foregroundColor(Color("TextGreyLight"))
                        
                            .font(.system(size: 14, weight: .medium))
                        Spacer()
                        Text("Listed \(viewModel.property.date_added)")
                            .foregroundColor(Color("TextGreyLight"))
                        
                            .font(.system(size: 14))
                    }
                    .padding(20)
                    //Spacer()
                        //.layoutPriority(1)
                }
                .background(Color(.white))
                .cornerRadius(30)
                .padding(16)
                .shadow(color: .black.opacity(0.1),radius: 5)
                .frame(height: 600)
            }
 
            
        
        
        
        
    }
}

struct CardLargeComponent_Previews: PreviewProvider {
    static var previews: some View {
        CardDiscoverComponent(viewModel: PropertyCardModel(property: propertyDemo, currentUser: userDemo))
    }
}
