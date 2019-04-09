//
//  PlaceDetailRouter.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

struct PlaceDetailRouter {
    weak var navigation: UINavigationController?
}

extension PlaceDetailRouter {
    
    func present(_ place: PlaceViewModel) {
        let scene = PlaceViewController(place)
        navigation?.show(scene, sender: nil)
    }
}
