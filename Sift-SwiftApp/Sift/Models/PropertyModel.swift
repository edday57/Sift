//
//  PropertyModel.swift
//  Sift
//
//  Created by Edward Day on 12/01/2023.
//

import Foundation
import MapKit
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
    var loc: CLLocation{
        return CLLocation(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
    }
}

let propertyDemo: Property = Property(_id: "x", address: "Balham Park Road, London, SW12", price: 3000, property_type: "Flat", bedrooms: 2, bathrooms: 2, latitude: 100, longitude: 100, images: ["https://media.rightmove.co.uk/211k/210110/117674516/210110_P235846_IMG_00_0000.jpeg", "https://media.rightmove.co.uk/29k/28962/121446902/28962_9997158_EAF_95819_IMG_00_0000.jpeg"], date_added: Date(timeIntervalSinceNow: 0), description: "Introducing a stunning two-bedroom Blueground apartment, available for flexible lease options in the heart of the vibrant Shoreditch community in London. With custom pricing available for any duration, you can enjoy this beautifully designed and fully-equipped home starting at £4,550 per month.\n\nStep inside and discover a thoughtfully furnished space, complete with top-of-the-line amenities such as gorgeous furniture, a fully-equipped kitchen, a smart TV, and a premium wireless speaker. The bedrooms are fitted with superior quality mattresses, luxury linens, and cozy towels to ensure a comfortable stay. Plus, with on-site building amenities such as an elevator and a washing machine, you'll have everything you need at your fingertips.", link: "link.com", agent:"x")
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
