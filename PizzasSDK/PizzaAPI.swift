//
//  PizzaAPI.swift
//  PizzasSDK
//
//  Created by Hernan G. Gonzalez on 08/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import Foundation
import Alamofire

enum PizzaAPI: NetworkAPI {
    case places
    case detail(String)
    case friends
    
    var baseURL: URL {
        return URL(string: "https://pizzaplaces.free.beeceptor.com/")!
    }

    var path: String {
        switch self {
        case .places:
            return "pizza"
        case .detail(let id):
            return "pizza/\(id)"
        case .friends:
            return "friends"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = baseURL
        url.appendPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = Alamofire.HTTPMethod.get.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(request)
    }
}
