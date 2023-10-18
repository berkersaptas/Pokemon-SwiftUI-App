//
//  EndPoint.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String? {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Endpoint {
    case pokemon
    case pokemonNextData(url: String)
    case pokemonDetail(url: String)
}

extension Endpoint: EndpointProtocol {
    
    
    var baseURL: String {
        switch self {
        case .pokemon: return "https://pokeapi.co"
        case .pokemonNextData(url: let url):
            return url
        case .pokemonDetail(url: let url):
            return url
        }
      
    }
    
    
    var path: String? {
        switch self {
        case .pokemon: return "/api/v2/pokemon"
        case .pokemonNextData(url: _): return nil
        case .pokemonDetail(url: _): return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .pokemon: return .get
        case .pokemonNextData: return .get
        case .pokemonDetail: return .get
        }
    }
    
    var header: [String : String]? {
        let header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    func request() -> URLRequest {
        
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }
        
        //Add Path
        if path != nil {
            components.path = path!
        }
        
        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        //Add Header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        //  print(request)
        return request
    }
}



