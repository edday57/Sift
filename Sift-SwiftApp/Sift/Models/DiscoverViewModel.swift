//
//  DiscoverViewModel.swift
//  Sift
//
//  Created by Edward Day on 24/01/2023.
//

import Foundation
import SwiftUI

class DiscoverViewModel: ObservableObject {

    @Published var properties: [Property] = []
    @Published var cfEnabled = false
    
    init(){
        if cfEnabled == false{
            getProperties(viewed:[""], views:[])
        }
        else{
            getPropertiesCF(viewed:[""])
        }
        
    }
    
    func getProperties(viewed: [String], views: [PropertyViewStruct]){

        views.forEach { view in
            print(view.id)
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
                    return
                }
        guard let id = defaults.string(forKey: "userid") else {
                    return
                }
        if cfEnabled == false{
            WebService().getDiscover(id: id, token: token, viewed: viewed, views: views) { (result) in
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
        else {
            WebService().getDiscoverCF(id: id, token: token, viewed: viewed) { (result) in
                switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.properties = data
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
                
            
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
                        self.properties = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        
        }
    }
}
