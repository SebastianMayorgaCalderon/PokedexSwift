//
//  GetPokemonDescriptionRequest.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/3/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import Moya

struct GetPokemonSpecieRequest {
    let id: Int
}

extension GetPokemonSpecieRequest: IRequest{
    typealias OutputType = PokemonSpecieDetailsResponse
    
    var path: String {
        return "pokemon-species/\(id)"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(from: "GET_pokemon_specie.json")
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
