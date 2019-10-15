//
//  PokemonRequest.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/18/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation

struct PokemonRequest {
    static func baseRequest(query: String) -> URLRequest {
        return URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(query.lowercased())")!)
    }
    
    static func speciesRequest(query: String) -> URLRequest {
        return URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(query.lowercased())")!)
    }
    
    static func imageRequest(id: Int) -> URLRequest {
        let searchId = String(format: "%03d", id)
        return URLRequest(url: URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(searchId).png")!)
    }
}
