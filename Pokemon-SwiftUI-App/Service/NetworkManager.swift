//
//  NetworkManager.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    struct ErrorResponse: Error {
        let status: String
        let errorModel : ErrorModel?
    }
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, ErrorResponse>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(ErrorResponse(status: error.localizedDescription, errorModel: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(ErrorResponse(status: "Invalid Response data", errorModel: nil)))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                do{
                    let decodedData = try JSONDecoder().decode(ErrorModel.self, from: data)
                    completion(.failure(ErrorResponse(status: "Invalid Response", errorModel: decodedData)))
                    return
                }
                catch let error {
                    completion(.failure(ErrorResponse(status: error.localizedDescription, errorModel:nil)))
                    return
                }
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch let error {
                // completion(.failure(error))
                completion(.failure(ErrorResponse(status: error.localizedDescription, errorModel: nil)))
            }
        }
        task.resume()
    }
    
    
    
    
    func fetchPokemonInitData(completion: @escaping (Result<PokemonListResponse, ErrorResponse>) -> Void) {
        let endpoint = Endpoint.pokemon
        request(endpoint, completion: completion)
    }
    func fetchPokemonNextData(url : String, completion: @escaping (Result<PokemonListResponse, ErrorResponse>) -> Void) {
        let endpoint = Endpoint.pokemonNextData(url: url)
        request(endpoint, completion: completion)
    }
     func fetchPokemonDetail(url : String, completion: @escaping (Result<PokemonDetailModel, ErrorResponse>) -> Void) {
         let endpoint = Endpoint.pokemonDetail(url: url)
        request(endpoint, completion: completion)
    }
    
    /*
     func login(email: String, password: String, completion: @escaping (Result<LoginModel, ErrorResponse>) -> Void) {
     let endpoint = Endpoint.login(email: email, password: password)
     request(endpoint, completion: completion)
     }
     
     func forgetPassword(email: String, completion: @escaping (Result<ForgetPasswordModel, ErrorResponse>) -> Void) {
     let endpoint = Endpoint.forgetPassword(email: email)
     request(endpoint, completion: completion)
     }
     
     func resetPassword(email: String, password: String, completion: @escaping (Result<LoginModel, ErrorResponse>) -> Void) {
     let endpoint = Endpoint.resetPassword(email: email, password: password)
     request(endpoint, completion: completion)
     }
     */
    
    /*
     // Tum endpintler buradan kontrol ediyoruz.
     func getUser(completion: @escaping (Result<[User], Error>) -> Void) {
     let endpoint = Endpoint.getUsers
     request(endpoint, completion: completion)
     }
     
     func getComments(postID: String, completion: @escaping (Result<CommentArray, Error>) -> Void) {
     let endpoint = Endpoint.comments(postID: postID)
     request(endpoint, completion: completion)
     }
     
     
     */
}
