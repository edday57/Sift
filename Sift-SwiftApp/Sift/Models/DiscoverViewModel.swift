//
//  DiscoverViewModel.swift
//  Sift
//
//  Created by Edward Day on 24/01/2023.
//

import Foundation

class DiscoverViewModel: ObservableObject {

    @Published var properties: [Property] = []
    
    init(){
        getProperties(viewed:[""])
    }
    
    func getProperties(viewed: [String]){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        guard let id = defaults.string(forKey: "userid") else {
                    return
                }
        print(id)
        WebService().getDiscover(id: id, token: token, viewed: viewed) { (result) in
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
