//
//  PokemonListView.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//
import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var viewModel = PokemonViewModel()
    @StateObject var appStorageManager = AppStorageManager()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 25) {
                ForEach(viewModel.pokemonList, id: \.id) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        ListItemView(pokemon: pokemon).onAppear {
                            viewModel.fetchNextData(pokemon: pokemon)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchInitData()
        }.padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Text("Pokemons").font(.title2)
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Image(systemName: "heart.fill").overlay(
                        Badge(value: .constant(appStorageManager.loadFavoritePokemon().count))
                    )
                })
            }
    }
    
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}


