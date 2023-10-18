//
//  PokemonModel.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//

import SwiftUI

struct Pokemon: Codable, Identifiable ,Equatable{
    let id = UUID()
    let name: String
    let url: String
}
