//
//  MapView.swift
//  Sift
//
//  Created by Edward Day on 23/02/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion()
    @State private var annotation = MKPointAnnotationWithID()
    @Binding var isPresented: Bool
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double, isPresented: Binding <Bool>) {
        self.latitude = latitude
        self.longitude = longitude
        _isPresented = isPresented
    }

    
    var body: some View {
        Map(coordinateRegion: .constant(region), annotationItems: [$annotation].compactMap({ $0 })) { _ in
                MapMarker(coordinate: annotation.coordinate, tint: Color("PrimaryBlue"))
            }
            .onAppear {
                let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
                let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                region = coordinateRegion
                annotation = MKPointAnnotationWithID()
                annotation.coordinate = initialLocation.coordinate
        }
        .ignoresSafeArea(edges: .all)
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        var showMap = true
//        MapView(latitude: 50, longitude: 20, isPresented: showMap)
//    }
//}

class MKPointAnnotationWithID: MKPointAnnotation, Identifiable {
    override init() {
        super.init()
    }
    
    var id = UUID()
}
