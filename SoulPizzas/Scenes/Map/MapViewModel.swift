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

struct MapViewModel {
    
    var title: String {
        return "Best pizza in town"
    }
    
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
    
    var error: Signal<Error, NoError> {
        return refresh.errors.map {
            $0 as Error
        }
    }
    
    func detail(with marker: GMSMarker) -> PlaceViewModel? {
        guard let marker = marker as? Marker else {
            return nil
        }
        return PlaceViewModel(marker.model)
    }
}

// MARK: Marker
class Marker: GMSMarker {
    fileprivate let model: Place
    
    init(_ place: Place) {
        model = place
        super.init()
        position = place.coordinate
        title = place.name
        snippet = place.formattedAddress
    }
    
    var thumbnail: URL? {
        return model.images.first?.url
    }
}
