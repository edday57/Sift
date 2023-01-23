//
//  FiltersModel.swift
//  Sift
//
//  Created by Edward Day on 23/01/2023.
//

import Foundation

class FiltersModel: ObservableObject{
    @Published var filters = Filters.loadFiltersFromUserDefaults()

}
struct Filters: Codable{
    var minPrice: Int?
    var maxPrice: Int?
    var minBeds: Int?
    var maxBeds: Int?
    var minBaths: Int?
    var maxBaths: Int?
    var property_type: [String]?
}

extension Filters {
    func saveFiltersToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: "searchFilters")
        }
    }
    
    static func loadFiltersFromUserDefaults() -> Filters? {
        if let data = UserDefaults.standard.data(forKey: "searchFilters"),
            let filters = try? JSONDecoder().decode(Filters.self, from: data) {
            return filters
        }
        return Filters()
    }
}
