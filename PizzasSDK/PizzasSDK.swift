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

// MARK: - Models
public struct Media: Decodable {
    let url: URL
}

public struct Place: Decodable {
    let id: String
    let latitude: Double
    let longitude: Double
    public let name: String
    public let images: [Media]
    public let formattedAddress: String
    
    public var coordinate: CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
}

public struct Friend: Decodable {
    let id: Int
    let name: String
    let avatarUrl: URL
}

// MARK: Internals
struct PlaceList: Decodable {
    let places: [Place]
}

struct PlacesResponse: Decodable {
    let list: PlaceList
}

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
    
    public static func friends(at place: Place) -> SignalProducer<[Friend], NetworkError> {
        let api = PizzaAPI.friends
        return api.producer()
    }
}


