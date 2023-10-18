//
//  PokemonViewModel.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 14.10.2023.
//

import SwiftUI


class PokemonViewModel: ObservableObject{
    
    @Published var pokemonList: [Pokemon] = [] {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    private var isLoading = false
    private var nextPageURL: String?
    
    private func  shouldLoadMoreData(_ pokemon: Pokemon) -> Bool {
        guard let lastPokemon = self.pokemonList.last else {
            return true
        }
        if pokemon.id == lastPokemon.id {
            return true
        }
        return false
    }
    
    func fetchInitData(){
        if self.pokemonList.isEmpty {
            NetworkManager.shared.fetchPokemonInitData{ result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.pokemonList = response.results
                    }
                    self.nextPageURL = response.next
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    
                }
            }
        }
    }
    
    
    func fetchNextData(pokemon: Pokemon) {
        if shouldLoadMoreData(pokemon) && !isLoading {
            if let nextURL = nextPageURL, !nextURL.isEmpty {
                NetworkManager.shared.fetchPokemonNextData(url: nextURL) { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                        self.pokemonList.append(contentsOf: response.results)
                    }
                        self.nextPageURL =  response.next
                    case .failure(let error):
                        print("Error fetching data: \(error)")
                    }
                    self.isLoading = false
                }
                isLoading = true
            }
        }
    }
    
}
