//
//  PokemonSpecieDetails.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/4/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

struct PokemonSpecieDetailsResponse: Decodable{
    let flavor_text_entries: [PokemonSpecieDescriptionResponse]
    let egg_groups: [PokemonSpecieEggGroupResponse]
    let genera: [GeneraResponse]
    
}

struct PokemonSpecieDetailLanguaje: Decodable {
    let name: String
    let url: String
}

struct PokemonSpecieDescriptionResponse: Decodable {
    let flavor_text: String
    let language: PokemonSpecieDetailLanguaje
}

struct PokemonSpecieEggGroupResponse: Decodable{
    let name: String
    let url: String
}
struct GeneraResponse: Decodable {
    let genus: String
}

