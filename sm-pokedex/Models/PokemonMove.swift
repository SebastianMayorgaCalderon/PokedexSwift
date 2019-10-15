//
//  PokemonMove.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/27/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

struct PokemonMove {
    var moveName: String!
    var url: String!
    init(moveName: String, url: String){
        self.moveName = moveName
        self.url = url
    }
}
