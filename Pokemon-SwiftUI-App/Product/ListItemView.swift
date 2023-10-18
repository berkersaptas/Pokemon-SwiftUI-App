//
//  ListItemView.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//

import SwiftUI

struct ListItemView: View {
    
    @StateObject var appStorageManager = AppStorageManager()
    
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: appStorageManager.checkFavoritePokemon(pokemon:pokemon) ? "heart.fill" : "heart").foregroundColor(.red).onTapGesture {
                if appStorageManager.checkFavoritePokemon(pokemon:pokemon) {
                    appStorageManager.removeFavoritePokemon(pokemon)
                }  else {
                    appStorageManager.addFavoritePokemon(pokemon)
                }
            }
            Text(pokemon.name)
            Spacer()
            Image(systemName:"chevron.forward")
        }
    }
}
