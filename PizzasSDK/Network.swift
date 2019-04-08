//
//  Network.swift
//  Polarsteps
//
//  Created by Hernan on 08/08/2018.
//  Copyright © 2018 Polarsteps. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityIndicator
import Reachability
import ReactiveSwift
import enum Result.Result
import enum Result.NoError

// Request
struct Network {
    typealias JSON = [String: Any]
    static var session = Alamofire.SessionManager.default
    
    static func prepare() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
}

// API:
protocol NetworkAPI: URLRequestConvertible {
}

extension NetworkAPI {
    typealias JSON = Network.JSON
    
    private func createRequest() -> DataRequest {
        let session = Network.session
        let request = session.request(self)
        return request.validate()
    }
    
    @discardableResult
    func object<Target: Decodable>(completion: @escaping ((Result<Target, NetworkError>) -> Void)) -> Alamofire.Request {
        typealias APIResult = Result<Target, NetworkError>
        
        let request = createRequest().responseData { response in
            // Result
            let result: APIResult
            switch response.result {
            case .success(let data):
                guard let value: APIResult.Value = data.decode() else {
                    result = .failure(.mapping)
                    break
                }
                result = .success(value)
            case .failure(let http):
                result = .failure(.http(http))
            }
            
            // Callback
            completion(result)
        }
        
        return request
    }
    
    func producer<Target: Decodable>() ->  SignalProducer<Target, NetworkError> {
        return SignalProducer { observer, lifetime in
            
            let request = self.object(completion: { (result: Result<Target, NetworkError>) in
                guard !lifetime.hasEnded else {
                    debugPrint("Observation ended, will not forward request results.")
                    return
                }
                
                switch result.result {
                case .success(let value):
                    observer.send(value: value)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            })
            
            lifetime.observeEnded {
                request.cancel()
            }
        }
    }
}

// Error:
public enum NetworkError: Error {
    case mapping
    case http(Error)
    case failure
    case offline
}

// MARK: Data
extension Data {
    
    static func emptyJSON() -> Data {
        let data = try? JSONSerialization.data(withJSONObject: [:], options: [])
        return data ?? Data()
    }
    
    func decode<Target: Decodable>() -> Target? {
        do {
            let decoder = JSONDecoder()
            let json = isEmpty ? Data.emptyJSON() : self
            let value = try decoder.decode(Target.self, from: json)
            return value
        } catch {
            debugPrint(error)
            return nil
        }
    }
}

// MARK: Reachable
extension Network {
    static func reachable() -> SignalProducer<Bool, NoError> {
        guard let reach = Reachability() else {
            return .empty
        }

        return SignalProducer { observer, lifetime in
            reach.whenReachable = { _ in
                observer.send(value: true)
            }
            reach.whenUnreachable = { _ in
                observer.send(value: false)
            }
            
            do {
                try reach.startNotifier()
            } catch {
                observer.send(value: false)
                observer.sendCompleted()
            }
            
            lifetime.observeEnded {
                reach.stopNotifier()
            }
        }
    }
}
