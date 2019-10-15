//
//  GetPokemonEvolutionChainRequest.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/12/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import Moya

struct GetPokemonEvolutionChainRequest {
    let id: Int
}

extension GetPokemonEvolutionChainRequest: IRequest{
    typealias OutputType = PokemonEvolutionChainResponse
    
    var path: String {
        return "evolution-chain/\(id)"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(from: "GET_pokemon_evolution_chain.json")
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
