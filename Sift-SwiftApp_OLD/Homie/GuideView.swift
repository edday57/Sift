//
//  GuideView.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Spacer()
            Text("Hey Homie!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color("PrimaryBlue"))
            Text("Looking to find the perfect place for you? Let's get started.")
                .multilineTextAlignment(.center)
            Spacer()
            GuideComponentView(icon: "house.circle", title: "Live", subtitle: "Swipe Right", description: "Some bullshit secondary text about why we're better than Rightmove. Even though you already know it.")
                .padding(.vertical, 10)
            GuideComponentView(icon: "heart.circle", title: "Love", subtitle: "Swipe Left", description: "Why live in somewhere second class. Get your shit together and get a drive for that Bugatti.")
                .padding(.vertical, 10)
            GuideComponentView(icon: "smiley", title: "Laugh", subtitle: "get more ", description: "Find the perfect housemates for you. Want to live in a house full of bitches? Lets do it.")
                .padding(.vertical, 10)
            Spacer()
            Button(action: {
                print("hi")
            }){
                Text("Continue".uppercased())
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding()
                    .background(Capsule()
                        .foregroundColor(Color("PrimaryBlue"))
                        )
                    
            }
            Spacer()
        }
        .padding(.horizontal, 25)
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
