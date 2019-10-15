//
//  PokemonDetailsViewModel.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/4/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Result
class PokemonDetailsViewModel{
    let error: Driver<Error>
    
    var pokemonDriver: Driver<Pokemon>
    
    var pokemonTypeCellIdentifier = "pokemon_type_cell"
    let pokemonTypes: Driver<[PokemonType]>
    let name :Driver<String>
    let description: Driver<String>
    let image : Driver<UIImage>
    let weight: Driver<String>
    let id: Driver<String>
    let height: Driver<String>
    
    init(
            pokemon: Pokemon,
            getPokemonDetails: @escaping (Int) -> (Driver<Result<PokemonDetailsResponse, Error>>),
            getPokemonSpecieDetails: @escaping (Int) -> (Driver<Result<PokemonSpecieDetailsResponse, Error>>)
        ) {
        let getPokemonDetailsRequest = getPokemonDetails(pokemon.id)
        
        
        self.pokemonDriver = getPokemonDetailsRequest
            .unwrapSuccess()
            .asObservable()
            .map{(getPokemonSpecieRequest: getPokemonSpecieDetails($0.id), pokemonDetails: $0, pokemonImage: pokemon.image)}
            .map{
                info in
                return info
                    .getPokemonSpecieRequest
                    .unwrapSuccess()
                    .asObservable()
                    .debug()
                    .flatMap{
                        Driver.of(
                            Pokemon(
                                id: info.pokemonDetails.id,
                                name: info.pokemonDetails.name.capitalized,
                                types: info.pokemonDetails.types.map{PokemonType(name: $0.type.name)},
                                description: $0.flavor_text_entries.map {PokemonDescription(text:$0.flavor_text, language: $0.language.name)},
                                height: info.pokemonDetails.height,
                                weight: info.pokemonDetails.weight,
                                image: info.pokemonImage
                            )
                        )
                    }
            }
            .flatMap{$0}
            .asDriver(onErrorJustReturn: pokemon)
        
        self.error = getPokemonDetailsRequest.unwrapError()
        self.name = pokemonDriver.map{$0.name}
        //TODO: find a way to save the langugae type in configuration
        self.description = pokemonDriver.map{$0.description.first(where: {$0.language == "it"})!.text}
        self.height = pokemonDriver.map{"Height: " + String($0.height)}
        self.weight = pokemonDriver.map{"Weight: " + String($0.weight)}
        self.id = pokemonDriver.map{"Id: " + String($0.id)}
        self.pokemonTypes = pokemonDriver.map{$0.types}
        self.image = pokemonDriver.map{$0.image}
       }
        
    }

