//
//  LoginView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
struct LoginView: View {
    @Binding var presentSignIn: Bool
    @State private var showSignUp = false
    @State private var email = ""
    @State private var password=""
    @EnvironmentObject var loginVM: LoginViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                Image(systemName: "house")
                    .resizable()
                    .fixedSize()
                    .aspectRatio( contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:UIScreen.main.bounds.height)
                    .offset(x: -300, y: 300)
                    .font(.system(size: 500))
                    .opacity(0.03)
                VStack(alignment: .center, spacing: 0) {
                    Image("Group 63")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.width)
                        .padding(.top, 20)
                    Text("Welcome to Sift.")
                        .font(.custom("Lora", size: 36))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("PrimaryText"))
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    VStack(alignment: .center, spacing: 20){
                        
                        //MARK: Email
                        VStack(alignment: .leading, spacing: 6){
                            Text("Email Address")
                                .opacity(0.5)
                                .font(.system(size: 16, weight: .regular))
                            TextField("ed@siftproperties.com", text: $email)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("StrokeGrey"))
                            
                        }
                        
                        
                        
                        //MARK: Password
                        VStack(alignment: .leading, spacing: 6){
                            Text("Password")
                                .opacity(0.5)
                                .font(.system(size: 16, weight: .regular))
                            SecureField("**********", text: $password)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("StrokeGrey"))
                            
                        }
                        
                        
                    }
                    .padding(.leading, 30)
                    
                    Button {
                                            loginVM.login(email: email, password: password)
                                            print (loginVM.isAuthenticated)
                                        } label: {
                                            Text("Sign In")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.vertical, 14)
                                                .frame(maxWidth: .infinity)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color("PrimaryBlue"))
                                                }
                                                
                                        }
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 40)
                    Button {
                        showSignUp.toggle()
                    } label: {
                        HStack{
                            Text("Don't have an account?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("PrimaryText"))
                            Text("Sign Up Here")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color("PrimaryText"))
                        }
                    }
                    .navigationDestination(isPresented: $showSignUp) {
                    SignUpView(presentSignUp: $showSignUp)
                }
                    .offset(y: -10)
                    .padding(.horizontal, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Button {
                                            loginVM.loginWithGoogle()
                                            print (loginVM.isAuthenticated)
                                        } label: {
                                            HStack{
                                                Image("GoogleLogo")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                Text("Sign In with Google")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color("PrimaryText"))
                                                    .padding(.vertical, 14)
                                            }
                                                .frame(maxWidth: .infinity)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color.white)
                                                        .shadow(color: .black.opacity(0.15),radius: 2, y: 2)
                                                }
                                                
                                        }
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 40)
//                    Button {
//                        presentSignIn = false
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Text("dismiss")
//                    }

                }
            }
            .navigationBarHidden(true)
        }

        

    }
    
    func handleSignInButton() {
      GIDSignIn.sharedInstance.signIn(
        withPresenting: ApplicationUtility.rootViewController) { signInResult, error in
          guard let result = signInResult else {
            // Inspect error
            return
          }
            print(result.user.description)
          // If sign in succeeded, display the app's main content View.
        }
      
    }


}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(presentSignIn: .constant(true))
            .environmentObject(LoginViewModel())
    }
}




