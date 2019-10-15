//
//  GetPokemons.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/26/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import Moya

struct GetPokemonsRequest {
    let offset: Int
}

extension GetPokemonsRequest: IRequest {
    typealias OutputType = PokemonListResponse
    var path: String {
        return "pokemon"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(from: "GET_pokemons.json")
    }
    
    var task: Task {
        let params: [String: Any] = [
            "offset": offset,
            "limit": 20
        ]
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
