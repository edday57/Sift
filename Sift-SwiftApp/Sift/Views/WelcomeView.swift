//
//  WelcomeView.swift
//  Articulate
//
//  Created by Edward Day on 02/12/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 12) {
                Image("UImockup")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 450)
                    .clipShape(RoundedRectangle(cornerRadius: 46))
                    .padding(20)
                    .shadow(color: .black.opacity(0.07), radius: 6, y:4)
                VStack(spacing:10){
                    Text("Get The Latest Updates\nTailored To You")
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)

                        
                    Text("Get The Most Popular Content \nBrought Straight To You")
                        .font(.system(size: 14))
                        .foregroundColor(Color("TextGreyLight"))
                        .multilineTextAlignment(.center)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("PrimaryBlue"))
                        .frame(width: 30, height: 4, alignment: .center)
                        .padding(20)
                        
                    Button {
                        //present sign up
                    } label: {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(height: 49)
                            .foregroundColor(Color("PrimaryBlue"))
                            .overlay {
                                Text("Sign Up With Email")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .padding(.leading,40)
                            .padding(.trailing,40)
                            .padding(.bottom, 20)
                    }
                    HStack(spacing: 0) {
                        Text("Already Have An Account? ")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextGreyDark"))
                        Button {
                            //login view
                        } label: {
                            Text("Sign In")
                                .font(.system(size: 14))
                                .foregroundColor(Color("PrimaryBlue"))
                        }

                    }
                }
                Spacer()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
