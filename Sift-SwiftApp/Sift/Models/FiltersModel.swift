//
//  FiltersModel.swift
//  Sift
//
//  Created by Edward Day on 23/01/2023.
//

import Foundation

class FiltersModel: ObservableObject{
    @Published var filters: Filters = Filters.loadFiltersFromUserDefaults()
    init(){
        print("init filters")
    }
    deinit{
        print("deinit filters")
    }
    static let shared = FiltersModel()
}
struct Filters: Codable{
    var minPrice: Int = 100
    var maxPrice: Int = 20000
    var minSize: Int = 100
    var maxSize: Int = 5000
    var minBeds: Int = -1
    var maxBeds: Int = -1
    var minBaths: Int = -1
    var maxBaths: Int = -1
    var property_type: [String] = []
}

extension Filters {
    func saveFiltersToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: "searchFilters")
        }
    }
    
    static func loadFiltersFromUserDefaults() -> Filters {
        if let data = UserDefaults.standard.data(forKey: "searchFilters"),
            let filters = try? JSONDecoder().decode(Filters.self, from: data) {
            return filters
        }
        return Filters()
    }
}
