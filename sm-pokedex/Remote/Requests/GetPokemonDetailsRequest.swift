//
//  GetPokemonDetails.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/26/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import Moya

struct GetPokemonDetailsRequest {
    let id: Int
}
extension GetPokemonDetailsRequest: IRequest {
    typealias OutputType = PokemonDetailsResponse
    
    var path: String {
        return "pokemon/\(id)"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(from: "GET_pokemon_details.json")
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
