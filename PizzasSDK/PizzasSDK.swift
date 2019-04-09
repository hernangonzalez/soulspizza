//
//  PizzasSDK.swift
//  PizzasSDK
//
//  Created by Hernan G. Gonzalez on 08/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//
import Alamofire
import ReactiveSwift
import CoreLocation

// MARK: - SDK
public struct PizzasSDK {
    
    public static func places() -> SignalProducer<[Place], NetworkError> {
        let api = PizzaAPI.places
        let producer = api.producer() as SignalProducer<PlacesResponse, NetworkError>
        return producer.map {
            $0.list.places
        }
    }
    
    public static func details(from place: Place) -> SignalProducer<Place, NetworkError> {
        let api = PizzaAPI.detail(place.id)
        return api.producer()
    }
    
    public static func friends(at place: Place) -> SignalProducer<[Profile], NetworkError> {
        let api = PizzaAPI.friends
        let producer = api.producer() as SignalProducer<[Profile], NetworkError>
        return producer.map {
            $0.filter {
                place.friendIds.contains($0.id.description)
            }
        }
    }
}


