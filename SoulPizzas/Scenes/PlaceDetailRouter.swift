//
//  PlaceDetailRouter.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import SwiftMessages

struct PlaceDetailRouter {
    weak var navigation: UINavigationController?
}

extension PlaceDetailRouter {
    
    private func showModal(_ place: PlaceViewModel) {
        let modal = MessageView.viewFromNib(layout: .tabView)
        modal.configureDropShadow()
        modal.configureTheme(.info)
        
        modal.configureIcon(withSize: .init(width: 60, height: 60), contentMode: .scaleToFill)
        modal.iconImageView?.kf.setImage(with: place.thumbnail)
        modal.configureContent(title: place.name, body: place.address)
        
        modal.button?.setTitle("Details", for: .normal)
        modal.buttonTapHandler = { _ in
            SwiftMessages.hide()
            self.present(place)
        }
        
        var config = SwiftMessages.Config()
        config.dimMode = .gray(interactive: true)
        config.duration = .forever
        config.interactiveHide = true
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: modal)
    }
    
    private func present(_ place: PlaceViewModel) {
        let scene = PlaceViewController(place)
        navigation?.show(scene, sender: nil)
    }
    
    func route(_ place: PlaceViewModel) {
        showModal(place)
    }
}
