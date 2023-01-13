//
//  SiftApp.swift
//  Sift
//
//  Created by Edward Day on 30/11/2022.
//

import SwiftUI

@main
struct ArticulateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoginViewModel.shared)
        }
    }
}
