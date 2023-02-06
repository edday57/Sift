//
//  LoginView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password=""
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 12) {
                HStack(){
                    Button {
                        //
                    } label: {
                        NavBarComponent(symbol: "chevron.left")
                    }
                    Text("Welcome Back")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom,20)
                
                Text("Login")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("TextGreyLight"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("StrokeGrey"), lineWidth: 2)
                        .frame(height: 42)
                        .foregroundColor(.white)
                        .overlay {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(Color("TextGreyLight"))
                                TextField("Email Address", text: $email)
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 10)
                        }
                        .padding(.leading,20)
                        .padding(.trailing,20)
                }
                .padding(.bottom, 8)
                Text("Password")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("TextGreyLight"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("StrokeGrey"), lineWidth: 2)
                        .frame(height: 42)
                        .foregroundColor(.white)
                        .padding(.bottom, 0)
                        .overlay {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(Color("TextGreyLight"))
                                SecureField("Enter Password", text: $password)
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 10)
                        }
                        .padding(.leading,20)
                        .padding(.trailing,20)
                }
                .padding(.bottom, 20)
                
                Button {
                    loginVM.login(email: email, password: password)
                    print (loginVM.isAuthenticated)
                } label: {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 49)
                        .foregroundColor(Color("PrimaryBlue"))
                        .overlay {
                            Text("Sign In")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                        .padding(.leading,40)
                        .padding(.trailing,40)
                }
                Spacer()

                Image("UImockup")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 46))
                    .padding(20)
                    .shadow(color: .black.opacity(0.07), radius: 6, y:4)

                    
            }
        }
        

    }


}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




