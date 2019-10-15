//
//  PokemonType.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/26/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
struct PokemonTypeResponse: Decodable {
    let slot: Int
    let type: PokemonTypeName
 
}
