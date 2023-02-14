//
//  SettingsView.swift
//  Sift
//
//  Created by Edward Day on 14/02/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        Button {
           logout()
        } label: {
            Text("Logout")
        }

    }
    
    func logout(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        defaults.removeObject(forKey: "searchFilters")
        defaults.removeObject(forKey: "userid")
        loginVM.currentUser = nil
        loginVM.isAuthenticated = false
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        return SettingsView()
    }
}
