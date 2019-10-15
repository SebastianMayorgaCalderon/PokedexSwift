//
//  PokemonList.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/1/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

struct PokemonListItemResponse: Decodable {
    let name: String
    let id: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        let url = try container.decode(String.self, forKey: .url)
        self.id = Int(
                url
                    .replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")
                    .replacingOccurrences(of:"/", with: "")
                )!
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

class PokemonListResponse : Decodable {
    let count: Int
    let next: String
    var results: [PokemonListItemResponse] = []
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try container.decode(Int.self, forKey: .count)
        self.next = try container.decode(String.self, forKey: .next)
        let test = try container.decode([PokemonListItemResponse].self, forKey: .results)
        self.results.append(contentsOf: test)
    }
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case results
    }
}
