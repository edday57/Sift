//
//  SignUpView.swift
//  Articulate
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @Binding var presentSignUp: Bool
    //MARK: Text Field Variables
    @State private var email = ""
    @State private var password=""
    @State private var confirmPassword=""
    @State private var name = ""
    @State var fromGoogle = false
    @State private var dob=Date()
    @State private var mobile = ""
    @State private var about = ""
    @State private var validationMessage = ""
    @EnvironmentObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let dateFormatter = DateFormatter()
    @State var currentIndex: Int = 0
    let lastIndex = 1
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
                
                HStack(spacing: 0){

                    
                    VStack(alignment: .center, spacing: 0) {
                        Image("Group 63")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size.width)
                            .padding(.top, 20)
                        Text("Get Started")
                            .font(.custom("Lora", size: 36))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("PrimaryText"))
                            .padding(.horizontal, 30)
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                            .offset(x: -CGFloat(currentIndex) * size.width)
                            .animation(.easeInOut(duration: 0.4), value: currentIndex)
                        VStack(alignment: .center, spacing: 20){
                            //MARK: Name
                            VStack(alignment: .leading, spacing: 6){
                                Text("Name")
                                    .opacity(0.5)
                                    .font(.system(size: 16, weight: .regular))
                                TextField("Edward Day", text: $name)
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("StrokeGrey"))
                                    
                            }
                            

                            
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

                            

                            
                            //MARK: Repeated Password
                            VStack(alignment: .leading, spacing: 6){
                                Text("Confirm Password")
                                    .opacity(0.5)
                                    .font(.system(size: 16, weight: .regular))
                                SecureField("**********", text: $confirmPassword)
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("StrokeGrey"))
                                    
                            }
                            Text(validationMessage)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("PrimaryBlue"))
                            
                            

                        }
                        .padding(.leading, 30)
                        .offset(x: -CGFloat(currentIndex) * size.width, y: 10)
                        .animation(.easeInOut(duration: 0.4).delay(0.1), value: currentIndex)
                        
                        
                        Spacer()
                        AsyncButton {
                            if currentIndex == 0 {
                                validationMessage = checkFields()
                                if validationMessage == ""{
                                    //Verify email
                                    Task{
                                        do{
                                            let exists = try await viewModel.checkEmailExists(email: email)
                                            if exists == false {
                                                currentIndex = 1
                                            }
                                            if exists == true {
                                               validationMessage = "Account already exists for this email"
                                            }
                                            
                                        }
                                        catch {
                                            //display error
                                            print("error")
                                        }
                                    }
                                }
                                else{
                                    //Password mismatch error
                                }
                                
                            }
                            //MARK: Sign Up Function
                            if currentIndex == lastIndex{
                                let email = email.isEmpty ? nil : email
                                let password = password.isEmpty ? nil : password
                                let name = name.isEmpty ? nil : name
                                let dob = isSameDay(date1: dob, date2: Date()) ? nil : dob
                                let about = about.isEmpty ? nil : about
                                let mobile = mobile.isEmpty ? nil : Int(mobile)
                                await viewModel.signUp(details: SignUpRequestBody(email: email, password: password, name: name, dob: dob, about: about, mobile: mobile, fromGoogle: fromGoogle))
                            }
                            //currentIndex += 1
                        } label: {
                            Text(currentIndex == lastIndex ? "Sign Up": "Continue")
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
                        .padding(.bottom, 40)

                    }
                    .overlay(alignment: .topLeading, content: {
                        Button {
                                presentSignUp = false
                                presentationMode.wrappedValue.dismiss()

                            
                        } label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(Color("PrimaryText"))
                                .fontWeight(.bold)
                        }
                        .offset(x:  -CGFloat(currentIndex) * size.width + 30, y:60)

                    })
                    .frame(width: size.width)
                    
                    
                    
                    VStack(alignment: .center, spacing: 0) {
                        Image("Group 63")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size.width)
                            .padding(.top, 20)
                        Text("About You")
                            .font(.custom("Lora", size: 36))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("PrimaryText"))
                            .padding(.horizontal, 30)
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                            .offset(x: -CGFloat(currentIndex) * size.width)
                            .animation(.easeInOut(duration: 0.4), value: currentIndex)
                        
                       
                        VStack(alignment: .center, spacing: 20){
                            //MARK: Profile Pic
                            VStack(alignment: .leading, spacing: 8){
                                Text("Profile Picture")
                                    .opacity(0.5)
                                    .font(.system(size: 16, weight: .regular))
                                Button {
                                    //
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .padding(.leading, 6)
                                        .font(.system(size: 20))
                                        .foregroundColor(Color("PrimaryText"))
                                }

                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("StrokeGrey"))
                                    
                            }
                            //.padding(.bottom, 40)
                            //MARK: Date of Birth
                            VStack(alignment: .leading){
                                Text("Date of Birth")
                                    .opacity(0.5)
                                Text(dob.formatted(date: .abbreviated, time: .omitted))
                                    .padding(.top, 1)
                                    .padding(.bottom, -1)
                                    .opacity(0.25)
                                    .overlay {
                                                        DatePicker(
                                                            "",
                                                            selection: $dob,
                                                            displayedComponents: .date
                                                        )
                                                        .tint(Color("PrimaryBlue"))
                                                        .blendMode(.destinationOver)
                                                    }
                                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("StrokeGrey"))
                                    
                            }
                            

                            //MARK: Mobile
                            VStack(alignment: .leading){
                                Text("Mobile Number")
                                    .opacity(0.5)
                                    .font(.system(size: 16, weight: .regular))
                                HStack{
                                    Text("+44")
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 3)
                                        .foregroundColor(.white)
                                        .background {
                                            Capsule()
                                                .opacity(0.3)
                                        }
                                    TextField("7342657339", text: $mobile)
                                        .keyboardType(.numberPad)
                                                    .onReceive(Just(mobile)) { newValue in
                                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                                        if filtered != newValue {
                                                            self.mobile = filtered
                                                        }
                                                    }
                                }
                                    
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("StrokeGrey"))
                                    
                            }
                            
                            
                            //MARK: About
                            VStack(alignment: .leading, spacing: 8){
                                Text("About")
                                    .opacity(0.5)
                                    .font(.system(size: 16, weight: .regular))
                                Text("A short profile helps a landlord to get to know you")
                                    .opacity(0.5)
                                    .font(.system(size: 10))
                                TextField("Final Year University Student", text: $about)
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("StrokeGrey"))
                                    
                            }
                            
                            
                            
                            
                        }
                        .padding(.leading, 30)
                        .offset(x: -CGFloat(currentIndex) * size.width, y: 10)
                        .animation(.easeInOut(duration: 0.4).delay(0.1), value: currentIndex)
                        
                        
                        Spacer()
                        

                    
                    }
                    .overlay(alignment: .topLeading, content: {
                        Button {
                            currentIndex -= 1
                            
                        } label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("PrimaryText"))
                                .fontWeight(.bold)
                        }
                        .offset(x: -CGFloat(currentIndex) * size.width + 30, y:60)

                    })
                    .frame(width: size.width)
                    
                    
                    
                    
                    
                    
                }
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
    func checkFields()-> String{
        if name.count < 3 || name.count > 24{
            return "Please check name"
        }
        else if textFieldValidatorEmail(email) == false {
            return "Please check email"
        }
        else if password.count < 6 || password.count > 30{
            return "Password must be at least 6 characters"
        }
        else if password != confirmPassword{
            return "Passwords do not match"
        }
        return ""
}

func textFieldValidatorEmail(_ string: String) -> Bool {
    if string.count > 100 {
        return false
    }
    let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: string)
}}

func isSameDay(date1: Date, date2: Date) -> Bool {
    let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
    if diff.day == 0 {
        return true
    } else {
        return false
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(presentSignUp: .constant(true))
    }
}
