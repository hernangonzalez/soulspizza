//
//  UIViewController+Error.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import SwiftMessages
import ReactiveSwift

extension UIViewController {
    
    func present(error: Error) {
        let message = MessageView.viewFromNib(layout: .cardView)
        message.configureTheme(.error)
        message.configureDropShadow()
        message.configureContent(title: "Ups! Something went wrong", body: error.localizedDescription)
        message.button?.isHidden = true
        SwiftMessages.show(view: message)
    }
}

extension Reactive where Base: UIViewController {
    
    var presentError: BindingTarget<Error> {
        return makeBindingTarget { base, error in
            base.present(error: error)
        }
    }
}


