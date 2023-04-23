//
//  SettingsView.swift
//  Sift
//
//  Created by Edward Day on 14/02/2023.
//

import SwiftUI
import MapKit
import CoreData
struct SettingsView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject var locationManager: LocationManager = .init()
    @Binding var showingMenu: Bool
    let presented: Bool
    var body: some View {
        VStack {
            if presented{
                Button(action: {
                    dismiss()
                    
                }, label: {
                    Image(systemName: "xmark")
                        .bold()
                        .foregroundColor(Color("TextGreyDark"))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            else{
                Button {
                    withAnimation(.spring()){
                        showingMenu.toggle()
                    }
                } label: {
                    MenuIcon().frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .opacity(showingMenu ? 0: 1)
                }
            }
           
            HStack(spacing: 10){
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Enter your preferred location", text: $locationManager.searchText)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .padding(.vertical,10)
            
            if let places = locationManager.fetchedPlaces,!places.isEmpty{
                List{
                    ForEach(places,id: \.self){place in
                        Button {
                            if let coordinate = place.location?.coordinate{
                                print(coordinate)
                                locationManager.pickedLocation = place.location
                                locationManager.saveLocation()
                            }

                        } label: {
                            HStack(spacing: 15){
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                        .foregroundColor(.primary)
                                    
                                    Text(place.locality ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                    }
                }
                .listStyle(.plain)
            }
            Spacer()
            Button {
               logout()
            } label: {
                Text("Logout")
                    .padding()
        }
        }

    }
    
    func logout(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        defaults.removeObject(forKey: "searchFilters")
        defaults.removeObject(forKey: "userid")
        deleteAll()
        loginVM.currentUser = nil
        loginVM.isAuthenticated = false
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = PropertyView.fetchRequest()
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = ImplicitRating.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? moc.execute(batchDeleteRequest1)
        _ = try? moc.execute(batchDeleteRequest2)
        try? moc.save()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        return SettingsView(showingMenu: .constant(false), presented: false)
    }
}
