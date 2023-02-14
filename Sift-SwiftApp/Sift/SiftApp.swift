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
 Agent View
 Add sort to discover
 Build out property card
 Improve discover loading
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
