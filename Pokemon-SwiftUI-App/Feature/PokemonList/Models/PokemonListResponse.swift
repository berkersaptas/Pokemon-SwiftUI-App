//
//  PokemonResponseModel.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [Pokemon]
    let next: String?
    let count: Int
    let previous: String?
}
