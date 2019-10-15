//
//  APIClient.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/17/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation

public struct PokemonAPI {
    public static func getPokemonBase(query: String, completion: @escaping (Model.Base?, Error?) -> ()) {
        let baseRequest = PokemonRequest.baseRequest(query: query)
        URLSession.shared.decodedDataTask(request: baseRequest, completion: completion).resume()
    }
    
    public static func getPokemonSpecies(query: String, completion: @escaping (Model.Species?, Error?) -> ()) {
        let speciesRequest = PokemonRequest.speciesRequest(query: query)
        URLSession.shared.decodedDataTask(request: speciesRequest, completion: completion).resume()
    }
    
    public static func getPokemonImageData(id: Int, completion: @escaping (Data?, Error?) -> ()) {
        let imageDataRequest = PokemonRequest.imageRequest(id: id)
        URLSession.shared.dataTask(request: imageDataRequest, completion: completion).resume()
    }
}
