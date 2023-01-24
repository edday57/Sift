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
        getProperties()
    }
    
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
