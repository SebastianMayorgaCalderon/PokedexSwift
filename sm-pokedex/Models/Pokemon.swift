//
//  Pokemon.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/4/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

struct Pokemon {
    let id: Int!
    let name: String!
    let types: [PokemonType]
    let description: [PokemonDescription]!
    let height: Int!
    let weight: Int!
    let image: UIImage!
}

struct PokemonType {
    let name : String
}
struct PokemonDescription{
    let text: String!
    let language: String!
}
