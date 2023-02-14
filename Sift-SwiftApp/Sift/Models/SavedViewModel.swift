//
//  SavedViewModel.swift
//  Sift
//
//  Created by Edward Day on 30/01/2023.
//

//import Foundation
//
//class SavedViewModel: ObservableObject {
//
//    @Published var savedProperties: [Property] = []
//    
//    init(){
//        getProperties()
//    }
//    
//    func getProperties(){
//        let defaults = UserDefaults.standard
//        guard let token = defaults.string(forKey: "jsonwebtoken") else {
//                    return
//                }
//        guard let id = defaults.string(forKey: "userid") else {
//                    return
//                }
//        WebService().getSavedProperties(id: id, skip: 0, token: token) { (result) in
//            switch result {
//                case .success(let properties):
//                    DispatchQueue.main.async {
//                        self.savedProperties = properties
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//            
//        
//        }
//    }
//}
