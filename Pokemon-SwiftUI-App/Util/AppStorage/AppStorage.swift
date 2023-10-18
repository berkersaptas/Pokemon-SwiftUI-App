//
//  AppStorage.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 14.10.2023.
//

import SwiftUI


class AppStorageManager: ObservableObject {
    
    
    @AppStorage("favoritePokemons") var favoritePokemonData: Data = Data()
    
    
    func saveFavoritePokemon(_ favoritePokemon: [Pokemon]) {
        if let encodedData = try? JSONEncoder().encode(favoritePokemon) {
            favoritePokemonData = encodedData
        }
    }
    
    func loadFavoritePokemon() -> [Pokemon] {
        if let favoritePokemon = try? JSONDecoder().decode([Pokemon].self, from: favoritePokemonData) {
            return favoritePokemon
        }
        return []
    }
    
    func addFavoritePokemon(_ pokemon: Pokemon) {
        var favoritePokemon = loadFavoritePokemon()
        if !favoritePokemon.contains(where: { $0.name == pokemon.name && $0.url == pokemon.url }) {
            favoritePokemon.append(pokemon)
            saveFavoritePokemon(favoritePokemon)
        }
    }
    
    func removeFavoritePokemon(_ removedPokemon: Pokemon) {
        var favoritePokemon = loadFavoritePokemon()
        favoritePokemon.removeAll(where: { $0.name == removedPokemon.name && $0.url == removedPokemon.url })
        saveFavoritePokemon(favoritePokemon)
    }
    
    func checkFavoritePokemon(pokemon : Pokemon) -> Bool {
        let favoritePokemon = loadFavoritePokemon()
        return favoritePokemon.contains(where: { $0.name == pokemon.name && $0.url == pokemon.url })
    }
    
    func removeFavoritePokemonAll() {
        favoritePokemonData.removeAll()
    }
    
    
}

