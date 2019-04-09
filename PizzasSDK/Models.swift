//
//  Models.swift
//  PizzasSDK
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import Foundation
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
