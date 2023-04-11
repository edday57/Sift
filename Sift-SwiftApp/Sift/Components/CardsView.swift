////
////  CardsView.swift
////  Sift
////
////  Created by Edward Day on 29/03/2023.
////
//
//import SwiftUI
//import Lottie
//struct CardsView: View {
//    @ObservedObject var viewModel: DiscoverViewModel
//    @State var loadingLottie = LottieAnimationView.init(name: "loading", bundle: .main)
//    let user: User
//    
//    @State var animate = false
//    @State var offset = 0
//    @State var offset2 = -40
//    @State var rotate = 0
//    @State var opacity2 = 1.0
//    @State var liked = false
//    @State var bgC = Color("Background")
//    @State var likeOpacity = 0.0
//    var body: some View {
//        GeometryReader{
//            let size = $0.size
//            ZStack{
//                if viewModel.propertiesCF.count == 0 {
//                    ResizeableLottieView2(lottie: $loadingLottie)
//                        .frame(width: size.width / 2, height: size.width / 2)
//                        .onAppear{
//                            loadingLottie.play()
//                        }
//                }
//                if viewModel.propertiesCF.count >= 2 {
//                    CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.propertiesCF[1], currentUser: user), bgC: .constant(Color("Background")), opacity: .constant(1.0), user: user)
//                        .scaleEffect(0.9)
//                        .offset(y: CGFloat(-40))
//                        .opacity(1-opacity2)
//                    CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.propertiesCF[1], currentUser: user), bgC: .constant(Color("Background")), opacity: $opacity2, user: user)
//                        .scaleEffect(animate ? 1 : 0.9)
//                        .offset(y: CGFloat(offset2))
//                }
//                ForEach(Array(viewModel.propertiesCF.prefix(1))){ property in
//                    CardSwipeComponent(viewModel: PropertyCardModel(property: property, currentUser: user), bgC: $bgC, opacity: .constant(0), user: user)
//                        .transition(.opacity)
//                        .animation(viewModel.propertiesCF.count == 11 ? .spring() : .none)
//                        .scaleEffect(animate ? 0.9 : 1)
//                        .offset(x: CGFloat(offset))
//                    //.rotation3DEffect(.degrees(Double(rotate)), axis: (x: 0, y: -1, z: 0), anchor: .center)
//                    //.blur(radius: animate ? 2: 0)
//                        .opacity(animate ? 0.5 : 1)
//                        .gesture(DragGesture().onEnded({ value in
//                            if value.translation.width > 100 {
//                                offset2 = -40
//                                opacity2 = 1
//                                withAnimation(.easeInOut(duration: 0.4)){
//                                    animate=true
//                                    offset = 330
//                                    offset2 = 0
//                                    rotate = 15
//                                    opacity2 = 0
//                                    bgC = Color("SecondaryBlue")
//                                    likeAnimation()
//                                }
//                                
//                            }
//                            if value.translation.width < -100 {
//                                offset2 = -40
//                                opacity2 = 1
//                                withAnimation(.easeInOut(duration: 0.4)){
//                                    animate=true
//                                    offset = -330
//                                    offset2 = 0
//                                    rotate = -15
//                                    opacity2 = 0
//                                }
//                            }
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                                animate = false
//                                rotate = 0
//                                offset = 0
//                                offset2 = -40
//                                opacity2 = 1
//                                bgC = Color("Background")
//                                viewModel.propertiesCF.remove(at: self.viewModel.propertiesCF.firstIndex(where:  {$0.id == property.id})!)
//                            }
//                            
//                            
//                        }))
//                }
//                VStack{
//                    ZStack(alignment: .top){
//                        Image(systemName: "heart.fill")
//                            .foregroundColor(Color("PrimaryBlue"))
//                            .font(.system(size: 60, weight: .semibold))
//                            .shadow(color: .black.opacity(1),radius: 10)
//                        
//                        Image(systemName: "heart")
//                            .foregroundColor(.white)
//                            .font(.system(size: 60, weight: .semibold))
//                    }
//                    .offset(y: 80)
//                    .opacity(likeOpacity)
//                    Spacer()
//                }
//            }
//        }
//    }
//    
//    func likeAnimation(){
//        withAnimation(.easeInOut(duration: 0.3)){
//            likeOpacity = 1
//
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
//            withAnimation(.easeInOut(duration: 0.5)){
//                likeOpacity = 0
//
//            }
//        }
//
//    }
//}
//
//struct CardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = DiscoverViewModel()
//        viewModel.properties=[propertyDemo, propertyDemo2]
//        return CardsView(viewModel: viewModel, user: userDemo)
//    }
//}
