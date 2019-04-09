//
//  UserCollectionViewModel.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import Foundation
import PizzasSDK
import ReactiveSwift
import Result

class UserCollectionViewModel {
    private let profiles = MutableProperty<[Profile]>([])
    private let disposables = ScopedDisposable(CompositeDisposable())
    
    init (at place: Place) {
        let producer = PizzasSDK.friends(at: place)
        profiles <~ producer.flatMapError { _ in
            return SignalProducer([])
        }
    }
}

extension UserCollectionViewModel {
    
    var count: Int {
        return profiles.value.count
    }
    
    func media(at index: Int) -> URL {
        return profiles.value[index].avatarUrl
    }
    
    var reload: Signal<Void, NoError> {
        return profiles.signal.map { _ in }
    }
}


