//
//  PizzasSDK.swift
//  PizzasSDK
//
//  Created by Hernan G. Gonzalez on 08/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//
import Alamofire
import ReactiveSwift

public struct Media: Decodable {
    let url: URL
}

public struct Place: Decodable {
    let id: String
    let name: String
    let images: [Media]
}

public struct Friend: Decodable {
    let id: Int
    let name: String
    let avatarUrl: URL
}

struct PlaceList: Decodable {
    let places: [Place]
}

struct PlacesResponse: Decodable {
    let list: PlaceList
}

public struct PizzasSDK {
    public init() {
        
    }
    
    public func fetchDetail() {
        let api = PizzaAPI.detail("3")
        let producer = api.producer() as SignalProducer<Place, NetworkError>
        producer.startWithResult { result in
            debugPrint(result.value!)
        }
    }

    public func fetchPlaces() {
        let api = PizzaAPI.places
        let producer = api.producer() as SignalProducer<PlacesResponse, NetworkError>
        producer.startWithResult { result in
            debugPrint(result.value!.list.places.count)
        }
    }
    
    public func fetchFriends() {
        let api = PizzaAPI.friends
        let producer = api.producer() as SignalProducer<[Friend], NetworkError>
        producer.startWithResult { result in
            debugPrint(result.value!)
        }
    }
    
    
}


