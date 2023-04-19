//
//  LocationService.swift
//  Sift
//
//  Created by Edward Day on 18/04/2023.
//

import SwiftUI
import CoreLocation
import MapKit
// MARK: Combine Framework to watch Textfield Change
import Combine

class LocationManager: NSObject,ObservableObject,MKMapViewDelegate,CLLocationManagerDelegate{
    // MARK: Properties

    
    // MARK: Search Bar Text
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?
    
    // MARK: Final Location
    @Published var pickedLocation: CLLocation?
    @Published var pickedPlaceMark: CLPlacemark?
    
    override init() {
        super.init()
        retrieveLoc()
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != ""{
                    self.fetchPlaces(value: value)
                }else{
                    self.fetchedPlaces = nil
                }
            })
    }
    
    func fetchPlaces(value: String){
        // MARK: Fetching places using MKLocalSearch & Asyc/Await
        Task{
            do{
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                // We can also Use Mainactor To publish changes in Main Thread
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
                        return item.placemark
                    })
                })
            }
            catch{
                // HANDLE ERROR
            }
        }
    }
    
    func saveLocation(){
        if let encodedLocation = try? NSKeyedArchiver.archivedData(withRootObject: pickedLocation!, requiringSecureCoding: false) {
            UserDefaults.standard.set(encodedLocation, forKey: "savedLocation")
        }
    }
    
    func retrieveLoc(){
        if let loadedLocation = UserDefaults.standard.data(forKey: "savedLocation"),
           let decodedLocation = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(loadedLocation) as? CLLocation {
            // Use the decodedLocation as you want
            pickedLocation = decodedLocation
        }
    }
}
