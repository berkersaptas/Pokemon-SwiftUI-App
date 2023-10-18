//
//  PokemonDetailViewModel.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 15.10.2023.
//

import SwiftUI

class PokemonDetailViewModel: ObservableObject{

    @Published var pokemondetail: PokemonDetailModel? = nil {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func fetchInitData(url : String ){
        NetworkManager.shared.fetchPokemonDetail(url: url){ result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.pokemondetail = response
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}
