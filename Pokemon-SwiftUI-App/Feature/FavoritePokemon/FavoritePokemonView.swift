//
//  FavoritePokemonView.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 14.10.2023.
//

import SwiftUI

struct FavoritePokemonView: View {
    @StateObject var appStorageManager = AppStorageManager()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 25) {
                ForEach(appStorageManager.loadFavoritePokemon()  , id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        ListItemView(pokemon: pokemon)
                    }
                }
            }
        }.padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Text("Favorites").font(.title2)
                })
            }
    }
}

struct FavoritePokemonView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePokemonView()
    }
}
