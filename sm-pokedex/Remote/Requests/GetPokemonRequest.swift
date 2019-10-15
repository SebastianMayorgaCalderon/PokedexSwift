//
//  GetPokemonDetails.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/26/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

class GetPokemonRequest {
    static var nextUrl = "https://pokeapi.co/api/v2/pokemon/"
    public static func fetch( completitionBlock: @escaping (PokemonList)->Void){
        guard let url = URL(string: nextUrl ) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            if let data = data {
                do{
                    let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                    self.nextUrl = pokemonList.next
                    DispatchQueue.main.async{completitionBlock(pokemonList)}
                }catch{}
            }
            }.resume()
    }
}
