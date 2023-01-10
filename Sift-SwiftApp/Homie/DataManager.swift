//
//  DataManager.swift
//  Homie
//
//  Created by Edward Day on 16/11/2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class DataManager: ObservableObject{
    @Published var properties: [Property_FB] = []
    
    init(){
        fetchProperties()
    }
    
    func fetchProperties(){
        properties.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Properties")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let address1 = data["address1"] as? String ?? ""
                    let address2 = data["address2"] as? String ?? ""
                    let bathrooms = data["bathrooms"] as? Int ?? 0
                    let bedrooms = data["bedrooms"] as? Int ?? 0
                    let price = data["price"] as? Float ?? 0
                    let postcode = data["postcode"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let property = Property_FB(address1: address1, address2: address2, postcode: postcode, price: price, bedrooms: bedrooms, bathrooms: bathrooms, image: image, id: id)
                    self.properties.append(property)
                }
            }
        }
        
    }
}
