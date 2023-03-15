//
//  SiftApp.swift
//  Sift
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI
import GoogleSignIn

/*
 Features:
 Add additional info for google sign up (present controller and update profile)
 Add additional details to sign up
 */


@main
struct ArticulateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoginViewModel.shared)
                .environmentObject(FiltersModel.shared)
                .onOpenURL { url in
                          GIDSignIn.sharedInstance.handle(url)
                        }
        }
    }
}
