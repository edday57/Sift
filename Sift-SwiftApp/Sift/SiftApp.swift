//
//  SiftApp.swift
//  Sift
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI


/*
 Features:
 Sign Up
 Home Page
 Liked Page
 Filters
 Profile View
 Agent View
 Search view
 Build out property card
 Like Property from card
 Improve discover loading
 Improve general loadng
 */


@main
struct ArticulateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoginViewModel.shared)
                .environmentObject(FiltersModel.shared)
        }
    }
}
