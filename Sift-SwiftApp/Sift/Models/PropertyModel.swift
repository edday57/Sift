//
//  PropertyModel.swift
//  Sift
//
//  Created by Edward Day on 12/01/2023.
//

import Foundation

struct Property: Codable, Identifiable {
    var id: String {
        return _id
    }
    var _id: String
    var address: String
    var price: Float
    var property_type: String
    var bedrooms: Int
    var bathrooms: Int
    var sizesqft: Int?
    var latitude: Float
    var longitude: Float
    var images: [String]
    var date_added: Date
    var description: String?
    var features: [String]?
    var let_type: String?
    var deposit: Int?
    var furnish_type: String?
    var link: String
    var agent: String
    var floorplan: String?
}

let propertyDemo: Property = Property(_id: "x", address: "Balham Park Road, London, SW12", price: 3000, property_type: "Flat", bedrooms: 2, bathrooms: 2, latitude: 100, longitude: 100, images: ["https://media.rightmove.co.uk/211k/210110/117674516/210110_P235846_IMG_00_0000.jpeg"], date_added: Date(timeIntervalSinceNow: 0), link: "link.com", agent:"x")
let propertyDemo2: Property = Property(_id: "xx", address: "Alba Gardens, Golders Green, London, NW11", price: 7600, property_type: "Flat", bedrooms: 3, bathrooms: 4, latitude: 100, longitude: 100, images: ["https://media.rightmove.co.uk/29k/28962/121446902/28962_9997158_EAF_95819_IMG_00_0000.jpeg"], date_added: Date(timeIntervalSinceNow: 0), link: "link.com", agent:"x")
class PropertyModel: ObservableObject {

    @Published var properties: [Property] = []
    @Published var savedProperties: [Property] = []
    var browseSkip = 0
    var savedSkip = 0
    
    init(){
        getProperties()
        getSavedProperties()
    }
    
    func refreshProperties(){
        browseSkip = 0
        getProperties()
    }
    
    func refreshSavedProperties(){
        savedSkip = 0
        getSavedProperties()
    }
    
    func getProperties(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        let filters = Filters.loadFiltersFromUserDefaults()
        WebService().getProperties(filters: filters, skip: self.browseSkip, token: token) { (result) in
            switch result {
                case .success(let properties):
                    DispatchQueue.main.async {
                        if self.browseSkip == 0{
                            self.properties = properties
                        }
                        else {
                            self.properties.append(contentsOf: properties)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }

    
    func getSavedProperties(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        guard let id = defaults.string(forKey: "userid") else {
                    return
                }
        let filters = Filters.loadFiltersFromUserDefaults()
        WebService().getSavedProperties(id: id, filters: filters, skip: self.savedSkip, token: token) { (result) in
            switch result {
                case .success(let properties):
                    DispatchQueue.main.async {
                        if self.savedSkip == 0{
                            self.savedProperties = properties
                        }
                        else {
                            self.savedProperties.append(contentsOf: properties)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
