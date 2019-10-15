//
//  PokemonDetails.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/26/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

struct PokemonDetailsResponse: Decodable {
    let id: Int
    let weight: Int
    let height: Int
    let name: String
    let types: [PokemonTypeResponse]
    let sprites: PokemonSpriteResponse
    let species: PokemonSpeciesResponse
    let stats: [PokemonStatResponse]
}

struct PokemonTypeResponse: Decodable {
    let slot: Int
    let type: PokemonTypeNameResponse
}

struct PokemonTypeNameResponse: Decodable {
    let name: String
    let url: String
}

struct PokemonSpriteResponse: Decodable{
    let front_default: String
}

struct PokemonSpeciesResponse : Decodable{
    let name: String
    let url : String
}

struct PokemonStatResponse: Decodable {
    let base_stat: Int
    let stat: StatDetails
}

struct StatDetails: Decodable {
    let name: String
    let url: String
}

