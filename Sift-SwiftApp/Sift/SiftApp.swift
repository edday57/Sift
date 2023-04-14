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
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoginViewModel.shared)
                .environmentObject(FiltersModel.shared)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onOpenURL { url in
                          GIDSignIn.sharedInstance.handle(url)
                        }
        }
    }
}
