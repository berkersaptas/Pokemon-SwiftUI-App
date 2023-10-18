//
//  PokemonDetailView.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 14.10.2023.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @ObservedObject var viewModel = PokemonDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    
    let pokemon : Pokemon
    
    var body: some View {
        GeometryReader { geometry in
            if(viewModel.pokemondetail == nil) {
                ProgressView().frame(width: geometry.size.width,height: geometry.size.height, alignment: .center)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: viewModel.pokemondetail!.sprites?.other?.officialArtwork?.frontDefault ?? "")
                        ) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                        .frame(height: geometry.size.height / 2.5)
                        Text("#\(String(format: "%04d", viewModel.pokemondetail!.id!)) \(viewModel.pokemondetail!.name ?? "")").font(.headline).padding(.vertical,20)
                        VStack(alignment: .leading,spacing: 30) {
                            PropertiesItemView(items: viewModel.pokemondetail!.types!, title: "Type")
                            { type in
                                Text(type.type?.name ?? "")
                            }
                            PropertiesItemView(items: viewModel.pokemondetail!.abilities!, title: "Ability") { ability in
                                Text(ability.ability?.name ?? "")
                            }
                            PropertiesItemView(items: calculator(calculatorType: .weight, value: viewModel.pokemondetail!.weight!) , title: "Weight") { weight in
                                Text(weight.value)
                            }
                            PropertiesItemView(items: calculator(calculatorType: .height, value: viewModel.pokemondetail!.height!) , title: "Height") { height in
                                Text(height.value)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "arrow.left")
                }
            }
        }
        .onAppear {
            viewModel.fetchInitData(url: pokemon.url)
        }
    }
}


struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon(name: "name", url: "https://pokeapi.co/api/v2/pokemon/1"))
    }
}


private struct Calculator : Identifiable {
    let id = UUID()
    let value : String
}

enum CalculatorType {
    case weight
    case height
}


private func calculator(calculatorType : CalculatorType, value : Int) -> [Calculator] {
    let divide = Double(value) / 10.0
    switch calculatorType {
    case .weight :
        // Convert to lbs
        let lbs = divide * 2.20462
        return [ Calculator(value: String(format: "%.1f kg",divide)), Calculator(value: String(format: "%.1f lbs",lbs)) ]
    case .height:
        return [ Calculator(value: String(format: "%.1f m",divide)) ]
    }
}
