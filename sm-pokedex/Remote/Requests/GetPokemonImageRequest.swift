//
//  GetPokemonImageRequest.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/28/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

struct GetPokemonImageRequest {
    let id: Int
}
extension GetPokemonImageRequest: IRequest {

    typealias OutputType = UIImage?
    
    var path: String {
        return "\(id).png" // find how to add new url
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(from: "GET_pokemons.json")
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
