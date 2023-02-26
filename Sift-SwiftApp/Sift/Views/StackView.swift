//
//  StackView.swift
//  Sift
//
//  Created by Edward Day on 25/02/2023.
//

import SwiftUI

struct StackView: View {
    @ObservedObject var viewModel = DiscoverViewModel()
    let user: User
    @State var animate = false
    @State var offset = 0
    @State var offset2 = -330
    @State var rotate = 0
    @State var rotate2 = -20
    @State var likeOpacity = 0.0
    @State var bgC = Color("Background")
    var body: some View {
        ZStack(alignment: .top){
            if viewModel.properties.count >= 2 {
                CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.properties[1], currentUser: user), bgC: .constant(Color("Background")))
                    .blur(radius: animate ? 0 : 2)
                                    .opacity(animate ? 1: 0.5)
                                    .scaleEffect(animate ? 1 : 0.8)
                                    .offset(x: CGFloat(offset2))
                                    .rotation3DEffect(.degrees(Double(rotate2)), axis: (x: 0, y: -1, z: 0), anchor: .center)
            }
            ForEach(Array(viewModel.properties.prefix(1))){ property in
                CardSwipeComponent(viewModel: PropertyCardModel(property: property, currentUser: user), bgC: $bgC)
                    .transition(.opacity)
                    //.animation(.spring())
                    .scaleEffect(animate ? 0.8 : 1)
                    .offset(x: CGFloat(offset))
                    .rotation3DEffect(.degrees(Double(rotate)), axis: (x: 0, y: -1, z: 0), anchor: .center)
                    //.blur(radius: animate ? 2: 0)
                    .opacity(animate ? 0.5 : 1)
                    .gesture(DragGesture().onEnded({ value in
                        if value.translation.width > 100 {
                            offset2 = -330
                            rotate2 = -20
                            
                            
                            withAnimation(.easeInOut(duration: 0.4)){
                                animate=true
                                offset = 330
                                offset2 = 0
                                rotate = 20
                                rotate2 = 0
                                bgC = Color("SecondaryBlue")
                                likeAnimation()
                            }
                            
                        }
                            if value.translation.width < -100 {
                                offset2 = 330
                                rotate2 = 20
                                withAnimation(.easeInOut(duration: 0.4)){
                                    animate=true
                                    offset = -330
                                    offset2 = 0
                                    rotate = -20
                                    rotate2 = 0
                                }
                            }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            animate = false
                            rotate = 0
                            rotate2 = -20
                            offset = 0
                            offset2 = -330
                            bgC = Color("Background")
                            viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                        }
                            
                        
                    }))
                    
                    
                    
                    
                
            }
            VStack{
                ZStack(alignment: .top){
                    
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("PrimaryBlue"))
                            .font(.system(size: 60, weight: .semibold))
                            .shadow(color: .black.opacity(1),radius: 10)
                    
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 60, weight: .semibold))
                }
                .offset(y: 80)
                .opacity(likeOpacity)
                Spacer()
            }
            
            
//            CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.properties[1], currentUser: user))
//                .blur(radius: animate ? 0 : 2)
//                .opacity(animate ? 1: 0)
//                .scaleEffect(animate ? 1 : 0.8)
//            CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.properties[0], currentUser: user))
//                //.padding(30)
//                .scaleEffect(animate ? 0.8 : 1)
//                .offset(x: CGFloat(offset))
//                .rotation3DEffect(.degrees(Double(rotate)), axis: (x: 0, y: -1, z: 0), anchor: .center)
//                //.blur(radius: animate ? 2: 0)
//                .opacity(animate ? 0: 1)
//                .gesture(DragGesture().onEnded({ value in
//                    if value.translation.width > 100 {
//                        withAnimation(.easeInOut(duration: 0.4)){
//                            animate=true
//                            offset = 330
//                            rotate = 15
//
//                        }
//                    }
//                        if value.translation.width < -100 {
//                            withAnimation(.easeInOut(duration: 0.4)){
//                                animate=true
//                                offset = -330
//                                rotate = -15
//                            }
//                        }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        animate = false
//                        rotate = 0
//                        offset = 0
//                    }
//
//
//                }))
//                .onAppear{
//                    withAnimation(.easeInOut(duration: 1).repeatForever()){
//                        rotate=true
//                    }
//                }
        }
    }
    
    func likeAnimation(){
        withAnimation(.easeInOut(duration: 0.3)){
            likeOpacity = 1

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            withAnimation(.easeInOut(duration: 0.5)){
                likeOpacity = 0

            }
        }

    }
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DiscoverViewModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return StackView(viewModel: viewModel, user: userDemo)
    }
}
