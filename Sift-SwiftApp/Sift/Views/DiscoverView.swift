//
//  DiscoverView.swift
//  Sift
//
//  Created by Edward Day on 15/01/2023.
//

import SwiftUI
import Lottie
struct DiscoverView2: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var views: FetchedResults<PropertyView>
    @State var animate = false
    @State var offset = 0
    @State var offset2 = -40
    @State var rotate = 0
    @State var opacity2 = 1.0
    @Binding var showingMenu: Bool
    @State var liked = false
    @State var bgC = Color("Background")
    @State var likeOpacity = 0.0
    @State var loadingLottie = LottieAnimationView.init(name: "loading", bundle: .main)
    @State private var showingInfoPopover = false
    @ObservedObject var viewModel: DiscoverViewModel
    let user: User
    @State var viewedProperties: [String] = [""]
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
                    Button {
                        showingInfoPopover = true
                    } label: {
                        Image(systemName: "info.circle")
                            .padding()
                    }
                    .popover(isPresented: $showingInfoPopover) {
                        VStack(alignment: .center,content: {
                            Text("Sift Discover")
                                .font(.custom("Lora", size: 36))
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryText"))
                                .padding()
                            Text("By using an advanced recommendation system, Sift takes the hassle out of finding your next home by doing the work for you.\n \nSwipe through properties in a familiar and fun way and Sift will learn from what you like to help find the perfect home for you. \n \nPlease Note: This feature is still in development so the accuracy of recommendations may vary. ")
                                .foregroundColor(Color("SecondaryText"))
                            Toggle("Collaborative Filtering", isOn: $viewModel.cfEnabled)
                            Spacer()
                        })
                        .padding()
                            .presentationDetents([.medium])
                    }

                    
                }
                .padding(20)
                //.padding(.top, 40)
                Spacer()
                
                //MARK: Cards
                ZStack{
                    //Show loading if no cards left
                    if viewModel.properties.count == 0 {
                        ResizeableLottieView2(lottie: $loadingLottie)
                            .frame(width: size.width / 2, height: size.width / 2)
                            .onAppear{
                                loadingLottie.play()
                            }
                    }
                    //If 2 cards or more cards show/animate second card in stack
                    if viewModel.properties.count >= 2 {
                        CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.properties[1], currentUser: user), bgC: .constant(Color("Background")), opacity: .constant(1.0), user: user)
                            .scaleEffect(0.9)
                            .offset(y: CGFloat(-40))
                            .opacity(1-opacity2)
                        CardSwipeComponent(viewModel: PropertyCardModel(property: viewModel.properties[1], currentUser: user), bgC: .constant(Color("Background")), opacity: $opacity2, user: user)
                            .scaleEffect(animate ? 1 : 0.9)
                            .offset(y: CGFloat(offset2))
                    }
                    //Visible card
                    ForEach(Array(viewModel.properties.prefix(1))){ property in
                        CardSwipeComponent(viewModel: PropertyCardModel(property: property, currentUser: user), bgC: $bgC, opacity: .constant(0), user: user)
                            .transition(.opacity)
                            //.animation(viewModel.properties.count == 11 ? .spring() : .none)
                            .scaleEffect(animate ? 0.9 : 1)
                            .offset(x: CGFloat(offset))
                            .opacity(animate ? 0.5 : 1)
                            .gesture(DragGesture().onEnded({ value in
                                if value.translation.width > 100 {
                                    trackEvent(name: "property_view", properties: ["listingId": property.id])
                                    self.viewedProperties.append(property.id)
                                    PropertyCardModel(property: property, currentUser: user).addLike()
                                    offset2 = -40
                                    opacity2 = 1
                                    withAnimation(.easeInOut(duration: 0.4)){
                                        animate=true
                                        offset = 330
                                        offset2 = 0
                                        rotate = 15
                                        opacity2 = 0
                                        bgC = Color("SecondaryBlue")
                                        likeAnimation()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        animate = false
                                        rotate = 0
                                        offset = 0
                                        offset2 = -40
                                        opacity2 = 1
                                        bgC = Color("Background")
                                        viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                        if viewModel.properties.isEmpty{
                                            var viewsArray: [PropertyViewStruct] = []
                                            for view in views{
                                                viewsArray.append( PropertyViewStruct(id: view.listingId!, user: user.id, date: view.date!))
                                            }
                                            viewModel.getProperties(viewed: viewedProperties, views: viewsArray)
                                        }
                                    }
                                    
                                    
                                }
                                if value.translation.width < -100 {
                                    trackEvent(name: "property_view", properties: ["listingId": property.id])
                                    self.viewedProperties.append(property.id)
                                    offset2 = -40
                                    opacity2 = 1
                                    withAnimation(.easeInOut(duration: 0.4)){
                                        animate=true
                                        offset = -330
                                        offset2 = 0
                                        rotate = -15
                                        opacity2 = 0
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        animate = false
                                        rotate = 0
                                        offset = 0
                                        offset2 = -40
                                        opacity2 = 1
                                        bgC = Color("Background")
                                        viewModel.properties.remove(at: self.viewModel.properties.firstIndex(where:  {$0.id == property.id})!)
                                        if viewModel.properties.isEmpty{
                                            var viewsArray: [PropertyViewStruct] = []
                                            for view in views{
                                                viewsArray.append( PropertyViewStruct(id: view.listingId!, user: user.id, date: view.date!))
                                            }
                                            viewModel.getProperties(viewed: viewedProperties, views: viewsArray)
                                        }
                                    }
                                    
                                    
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
    
    func trackEvent(name: String, properties: [String: Any]) {
        switch name{
        case "property_view":
            for view in views{
                if view.listingId == (properties["listingId"] as! String) {
                    view.date = Date()
                    try? moc.save()
                    return
                }
            }
            //View not found
            let view = PropertyView(context: moc)
            view.listingId = (properties["listingId"] as! String)
            view.date = Date()
            try? moc.save()
            return
        default:
            return
        }
        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DiscoverViewModel()
        viewModel.properties=[propertyDemo, propertyDemo2]
        return DiscoverView2(showingMenu: .constant(true),viewModel: viewModel, user: userDemo)
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
