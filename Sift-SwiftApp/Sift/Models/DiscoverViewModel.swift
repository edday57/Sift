//
//  DiscoverViewModel.swift
//  Sift
//
//  Created by Edward Day on 24/01/2023.
//

import Foundation

class DiscoverViewModel: ObservableObject {

    @Published var properties: [Property] = []
    @Published var propertiesCF: [Property] = []
    
    init(){
        getProperties(viewed:[""])
        getPropertiesCF(viewed:[""])
    }
    
    func getProperties(viewed: [String]){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        guard let id = defaults.string(forKey: "userid") else {
                    return
                }
        WebService().getDiscover(id: id, token: token, viewed: viewed) { (result) in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.properties = data.discoverProperties
                        self.properties.append(contentsOf: data.additionalProperties)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }
    func getPropertiesCF(viewed: [String]){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        guard let id = defaults.string(forKey: "userid") else {
                    return
                }
        WebService().getDiscoverCF(id: id, token: token, viewed: viewed) { (result) in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.propertiesCF = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }
}
