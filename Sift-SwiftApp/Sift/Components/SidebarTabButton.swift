//
//  SidebarTabButton.swift
//  Sift
//
//  Created by Edward Day on 17/02/2023.
//

import SwiftUI
import CoreData
struct SidebarTabButton: View {
    var image: String
    var title: String
    @EnvironmentObject var loginVM: LoginViewModel
    @Environment(\.managedObjectContext) var moc
    @Binding var selectedTab: String
    var animation: Namespace.ID
    var body: some View {
       
        Button {
            withAnimation(.spring()){
                selectedTab = title
            }
            if title == "Log Out"{
                logout()
                //log out user
            }
        } label: {
            HStack(spacing: 15){
                Image(systemName: image)
                    .frame(width: 30)
                Text(title)
                    .fontWeight(title == "Log Out" ? .semibold : .black)
                if title == "Inbox"{
                    Text("(3)")
                        .fontWeight(.black)
                }
            }
            .foregroundColor(selectedTab == title ? Color("PrimaryBlue") : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background{
                ZStack{
                    if selectedTab == title{
                        Color.white
                            .opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 8))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                
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

struct SidebarTabButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
