//
//  PlaceViewModel.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import Foundation
import PizzasSDK
import Kingfisher

struct PlaceViewModel {
    private let place: Place
    
    init(_ model: Place) {
        place = model
    }
}

extension PlaceViewModel {
    
    var name: String {
        return place.name
    }
    
    var thumbnail: Resource? {
        return place.images.first?.url
    }
    
    var friends: UserCollectionViewModel {
        return UserCollectionViewModel(at: place)
    }
}

