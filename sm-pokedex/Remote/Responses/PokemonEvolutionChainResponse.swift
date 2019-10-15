//
//  PokemonEvolutionChainResponse.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/12/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation

struct PokemonEvolutionChainResponse: Decodable {
    let id: Int
    let chain: EvolutionChainResponse
}

struct EvolutionChainResponse: Decodable {
    let evolves_to: [EvolvesToResponse]
}

struct EvolvesToResponse: Decodable {
    let evolution_details: [EvolutionDetailsResponse]
    let evolves_to: [EvolvesToResponse]
}

struct EvolutionDetailsResponse: Decodable {
    let min_level: Int
}
