//
//  AgentViewModel.swift
//  Sift
//
//  Created by Edward Day on 15/02/2023.
//

import Foundation

class AgentViewModel: ObservableObject{
    let agent: User
    @Published var properties: [Property] = []
    var skip = 0
    
    init(agent: User){
        self.agent = agent
        Task{
            await self.getProperties()
        }
    }
    
    func getProperties () async{
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        do {
            let data =  try await WebService().aGetAgentProperties(id: agent.id, skip: skip, token:token)
            if skip == 0 {
                await MainActor.run{
                    self.properties = data
                }
                print("Loaded agent properties")
            }
            else{
                await MainActor.run{
                    self.properties.append(contentsOf: data)
                    print("Loaded more agent properties")
                }
            }
        } catch {
            print("Error: ", error)
        }
        
    }
    
}
