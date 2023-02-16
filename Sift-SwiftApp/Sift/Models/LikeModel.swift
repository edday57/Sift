//
//  LikeModel.swift
//  Sift
//
//  Created by Edward Day on 14/02/2023.
//

import Foundation

class LikeModel: ObservableObject {
    @Published var likedPosts: [String] = []
    var currentUser: User
    
    init(currentUser: User){
        self.currentUser = currentUser
        Task{
            await AgetLikes()
        }
        
    }
    
    func AgetLikes() async{
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
        }
        do {
            let data =  try await WebService().AgetLikes(id: currentUser.id, token:token)
            await MainActor.run{
                self.likedPosts = data
            }
            print("Likes retrieved")
        } catch {
            print("Error: ", error)
        }
            
    }
    
    func AaddLike(listingID: String) async{
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        do {
            try await WebService().AaddLike(user: currentUser.id, listing: listingID, token: token)
            print("Likes added")
            await MainActor.run{
                self.likedPosts.append(listingID)
            }
            
        } catch {
            print("Error: ", error)
        }
    }
    
    func AtoggleLike(listingID: String) async{
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        do {
            let status = try await WebService().AtoggleLike(user: currentUser.id, listing: listingID, token: token)
            if status == 200 {
                print("Like removed")
                if likedPosts.contains(listingID){
                    await MainActor.run{
                        self.likedPosts.remove(object: listingID)
                    }
                }
            }
            else if status == 201 {
                print("Like added")
                await MainActor.run{
                    self.likedPosts.append(listingID)
                }
            }
            
        } catch {
            print("Error: ", error)
        }
    }
}
