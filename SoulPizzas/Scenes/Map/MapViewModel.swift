//
//  MapViewModel.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 08/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import Foundation
import PizzasSDK
import ReactiveSwift
import CoreLocation
import GoogleMaps

struct MapViewModel {
    private let items = MutableProperty<[CLLocationCoordinate2D]>([])
}

extension MapViewModel {
    
    func updateResults() {
        items.value = [CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20),
                       CLLocationCoordinate2D(latitude: -32.86, longitude: 150.20),
                       CLLocationCoordinate2D(latitude: -31.86, longitude: 152.20)]
    }
    
    var markers: Property<[GMSMarker]> {
        let markers = items.map { coords -> [GMSMarker] in
            return coords.map {
                let marker = GMSMarker()
                marker.position = $0
                marker.title = $0.latitude.description
                marker.snippet = $0.longitude.description
                return marker
            }
        }
        return Property(capturing: markers)
    }
}
