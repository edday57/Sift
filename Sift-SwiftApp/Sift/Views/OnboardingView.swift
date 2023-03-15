//
//  OnboardingView.swift
//  Sift
//
//  Created by Edward Day on 14/02/2023.
//

import SwiftUI
import Lottie

struct OnboardingView: View {
    
    //MARK: Onboarding Info Init
    @State private var showLogin = false
    @State var onboardingItems : [OnboardingItem] = [
        .init(title: "Welcome To Sift", subtitle: "Stay Up-to-Date with the Latest Properties on the Market: Browse the Newest Listings with Our App's Easy-to-Use Search and Filtering Features!", lottieView: .init(name: "house", bundle: .main)),
        .init(title: "Perfect For You", subtitle: "Our Advanced Algorithm Analyzes Your Preferences and Provides Personalized Suggestions, So You Can Discover Properties You'll Love in No Time!", lottieView: .init(name: "city", bundle: .main)),
        .init(title: "Find Flatmates", subtitle: "With Our Advanced Search and Matching System, You Can Connect with Like-Minded People, Ensure Compatibility and Enjoy the Benefits of Shared Accommodation!", lottieView: .init(name: "people", bundle: .main))]
    
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            HStack(spacing: 0){
                ForEach($onboardingItems){ $item in
                    let isLast = (currentIndex == onboardingItems.count - 1)
                    VStack{
                        //MARK: Navbar
                        HStack(){
                            Button {
                                if currentIndex > 0{
                                    currentIndex -= 1
                                }
                            } label: {
                                Text("Back")
                                    .opacity(currentIndex > 0 ? 1 : 0)
                            }
                            Spacer()
                            Button {
                                currentIndex = onboardingItems.count - 1
                            } label: {
                                Text("Skip")
                                    .opacity(isLast ? 0: 1)
                            }


                        }
                        .animation(.easeInOut, value: currentIndex)
                        .foregroundColor(.black)
                        .tint(Color("PrimaryBlue"))
                        .fontWeight(.bold)
                        
                        //MARK: Moveable Slides
                        VStack(spacing: 15){
                            let offset = -CGFloat(currentIndex) * size.width
                            
                                ResizeableLottieView(onboardingItem: $item)
                                    .frame(width: size.width * CGFloat(0.8), height: size.width)
                                    .onAppear{
                                        if currentIndex == indexOf(item){
                                            item.lottieView.play()
                                        }
                                    }
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.4), value: currentIndex)
                            
                            //MARK: Lottie View
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.4).delay(0.1), value: currentIndex)
                            Text(item.subtitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.4).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer()
                        
                        //MARK: Next/Login Button
                        VStack(spacing: 15){

                            Text(isLast ? "Login" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, isLast ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background{
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("PrimaryBlue"))
                                }
                                .padding(.horizontal, isLast ? 30: 100)
                                .onTapGesture {
                                    if currentIndex < onboardingItems.count - 1{
                                        //onboardingItems[currentIndex].lottieView.pause()
                                        currentIndex += 1
                                        onboardingItems[currentIndex].lottieView.play()
                                        
                                    }
                                    else {
                                        showLogin = true
                                    }
                                }
                                .navigationDestination(isPresented: $showLogin) {
                                LoginView(presentSignIn: $showLogin)
                            }
                               
                            HStack{
                                Text("Terms of Service")
                                
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline()
                            .offset(y: 5)
                        }
                    }
                    .animation(.easeInOut, value: isLast)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
        }
    }
    
    func indexOf(_ item: OnboardingItem) -> Int{
        if let index = onboardingItems.firstIndex(of: item){
            return index
        }
        return 0
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct ResizeableLottieView: UIViewRepresentable{
    @Binding var onboardingItem: OnboardingItem
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView){
        let lottieView = onboardingItem.lottieView
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
