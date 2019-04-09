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
import Result

class Marker: GMSMarker {
    private let model: Place
    
    init(_ place: Place) {
        model = place
        super.init()
        position = place.coordinate
        title = place.name
        snippet = place.formattedAddress
    }
}

struct MapViewModel {
    
    let refresh: Action<Void, [Marker], NetworkError> = Action {
        return PizzasSDK.places().map {
            $0.map {
                Marker($0)
            }
        }
    }
    
    var markers: Signal<[Marker], NoError> {
        return refresh.values
    }
}

