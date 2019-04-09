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
    public let url: URL
}

public struct Place: Decodable {
    let id: String
    let latitude: Double
    let longitude: Double
    let friendIds: [String]
    public let name: String
    public let images: [Media]
    public let formattedAddress: String
    
    public var coordinate: CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
}

public struct Profile: Decodable {
    let id: Int
    public let name: String
    public let avatarUrl: URL
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


