//
//  DiscoverView.swift
//  Sift
//
//  Created by Edward Day on 15/01/2023.
//

import SwiftUI
import Lottie
struct DiscoverView2: View {
    @State var animate = false
    @State var offset = 0
    @State var offset2 = -330
    @State var rotate = 0
    @State var rotate2 = -15
    @Binding var showingMenu: Bool
    @State var liked = false
    @State var bgC = Color("Background")
    @State var likeOpacity = 0.0
    @State var loadingLottie = LottieAnimationView.init(name: "loading", bundle: .main)
    @ObservedObject var viewModel: DiscoverViewModel
    let user: User
    @State var viewedProperties: [String] = ["63c8279a5b061b24d6897c5d"]
    var body: some View {
        GeometryReader{
            let size = $0.size
            VStack(spacing: 0){
                Button {
                    withAnimation(.spring()){
                        showingMenu.toggle()
                    }
                } label: {
                    MenuIcon().frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .opacity(showingMenu ? 0: 1)
                }

                
                HStack{
                    Text("For You")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(Color("PrimaryText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    Image(systemName: "info.circle")
                }
                .padding(20)
                //.padding(.top, 40)
                Spacer()
                ZStack{
                    if viewModel.properties.count == 0 {
                        ResizeableLottieView2(lottie: $loadingLottie)
                            .frame(width: size.width / 2, height: size.width / 2)
                            .onAppear{
                                loadingLottie.play()
                            }
                    }
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
                            .animation(viewModel.properties.count == 11 ? .spring() : .none)
                            .scaleEffect(animate ? 0.8 : 1)
                            .offset(x: CGFloat(offset))
                            .rotation3DEffect(.degrees(Double(rotate)), axis: (x: 0, y: -1, z: 0), anchor: .center)
                        //.blur(radius: animate ? 2: 0)
                            .opacity(animate ? 0.5 : 1)
                            .gesture(DragGesture().onEnded({ value in
                                if value.translation.width > 100 {
                                    offset2 = -330
                                    rotate2 = -15
                                    withAnimation(.easeInOut(duration: 0.4)){
                                        animate=true
                                        offset = 330
                                        offset2 = 0
                                        rotate = 15
                                        rotate2 = 0
                                        bgC = Color("SecondaryBlue")
                                        likeAnimation()
                                    }
                                    
                                }
                                if value.translation.width < -100 {
                                    offset2 = 330
                                    rotate2 = 15
                                    withAnimation(.easeInOut(duration: 0.4)){
                                        animate=true
                                        offset = -330
                                        offset2 = 0
                                        rotate = -15
                                        rotate2 = 0
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    animate = false
                                    rotate = 0
                                    rotate2 = -15
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
                }
                HStack(spacing: 0){
                    ZStack{
                        Rectangle()
                            .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                            .frame(height: 70)
                            .foregroundColor(Color("PrimaryBlue"))
                            .overlay(alignment: .trailing) {
                                Triangle()
                                    .frame(width: 20)
                                    .foregroundColor(.white)
                            }
                        Text("Save Listing")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .heavy))
                    }
                    ZStack{
                        Rectangle()
                            .cornerRadius(10, corners: [.topRight, .bottomRight])
                            .frame(height: 70)
                            .foregroundColor(.white)
                        Text("Contact Agent")
                            .foregroundColor(Color("PrimaryBlue"))
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                    
                }
                
                .background{
                    Color.white
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(20)
                .cornerRadius(10)
                }
        }


        
    }
    
    func likeAnimation(){
        withAnimation(.easeInOut(duration: 0.3)){
            likeOpacity = 1

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            withAnimation(.easeInOut(duration: 0.5)){
                likeOpacity = 0

            }
        }

    }
}

struct DiscoverView: View {
    @Binding var showingMenu: Bool
    @State var liked = false
    @State var bgC = Color.white
    @ObservedObject var viewModel = DiscoverViewModel()
    let user: User
    @State var viewedProperties: [String] = ["63c8279a5b061b24d6897c5d"]
    var body: some View {
        VStack(spacing: 0){
            Button {
                withAnimation(.spring()){
                    showingMenu.toggle()
                }
            } label: {
                MenuIcon().frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .opacity(showingMenu ? 0: 1)
            }

            
            HStack{
                Text("For You")
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(Color("PrimaryText"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                Image(systemName: "info.circle")
            }
            .padding(20)
            //.padding(.top, 40)
            Spacer()
                ZStack {
                    ForEach(Array(viewModel.properties.prefix(1))){ property in
                        CardSwipeComponent(viewModel: PropertyCardModel(property: property, currentUser: user), bgC: $bgC)
                        .buttonStyle(FlatLinkStyle())
                        .animation(.spring())
                        //.transition(liked ? .slide : .backslide)
                        .simultaneousGesture(DragGesture()
                                                    .onEnded { value in
                                                        
                                                        if value.translation.width < -100 {
                                                            liked = false
                                                            self.viewedProperties.append(property.id)
                                                            //self.viewedCards.append(card)
                                                            self.viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                                            if viewModel.properties.isEmpty{
                                                                viewModel.getProperties(viewed: viewedProperties)
                                                            }
                                                        }
                                                        if value.translation.width > 100 {
                                                            liked = true
                                                            withAnimation(.spring()){
                                                                
                                                            }
                                                            self.viewedProperties.append(property.id)
                                                                
                                                            //Add like
                                                            print("add like")
                                                            PropertyCardModel(property: property, currentUser: user).addLike()
                                                            //Get properties
                                                            self.viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                                            
                                                            if viewModel.properties.isEmpty{
                                                                viewModel.getProperties(viewed: viewedProperties)
                                                            }
                                                        }
                                                            
                                                    }
                                                )
                        .transition(liked ? .slide : .backslide)
                        //.animation(.spring())

                    }
                    
                }
            HStack(spacing: 0){
                ZStack{
                    Rectangle()
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                        .frame(height: 70)
                        .foregroundColor(Color("PrimaryBlue"))
                        .overlay(alignment: .trailing) {
                            Triangle()
                                .frame(width: 20)
                                .foregroundColor(.white)
                        }
                    Text("Save Listing")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .heavy))
                }
                ZStack{
                    Rectangle()
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .frame(height: 70)
                        .foregroundColor(.white)
                    Text("Contact Agent")
                        .foregroundColor(Color("PrimaryBlue"))
                        .font(.system(size: 16, weight: .semibold))
                }
                
                
            }
            
            .background{
                Color.white
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(20)
            .cornerRadius(10)
            }

        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DiscoverViewModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return DiscoverView(showingMenu: .constant(true),viewModel: viewModel, user: userDemo)
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}

struct ResizeableLottieView2: UIViewRepresentable{
    @Binding var lottie: LottieAnimationView
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView){
        let lottieView = lottie
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.loopMode = .loop

        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),]
        to.addSubview(lottieView)
        to.addConstraints(constraints)

    }
}
