//
//  PropertyModel.swift
//  Sift
//
//  Created by Edward Day on 12/01/2023.
//

import Foundation

struct Property: Identifiable, Codable {
    var address: String
    var price: Float
    var property_type: String
    var bedrooms: Int
    var bathrooms: Int
    var sizesqft: Int?
    var locX: Float
    var locY: Float
    var images: [String]?
    var date_added: String
    var description: String?
    struct rent_details: Codable {
        var let_type: String?
        var deposit: Int?
        var furnish_type: Int?
    }
    var link: String
    var floorplan: String?
    var id: String
    
}

class PropertyModel: ObservableObject {

    @Published var properties: [Property] = []
    
    func getProperties(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        WebService().getProperties(token: token) { (result) in
            switch result {
                case .success(let properties):
                    DispatchQueue.main.async {
                        self.properties = properties
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }
}
