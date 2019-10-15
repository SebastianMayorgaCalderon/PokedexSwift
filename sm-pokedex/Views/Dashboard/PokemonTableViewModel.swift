//
//  PokemonTableViewModel.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/4/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Result

class PokemonTableViewModel {
    
    let cellPokemonIdentifier = "pokemon_cell"
    let limit = 964
    let appTitle = "POKEDEX"
    
    let nextPageTrigger = PublishRelay<Void>()
    let getPokemons = PublishRelay<Int>()
    
    let isFetching: Driver<Bool>
    let pokemonList: Driver<[PokemonUIDetails]>
    let error: Driver<Error>
    
    let fetchPokemonsActivityIndicator = ActivityIndicator()
    private let disposeBag = DisposeBag()
    
    init(
            getPokemonRequest: @escaping (Int)-> (Driver<Result<PokemonListResponse, Error>>),
            getPokemonImage: @escaping (Int) -> (Driver<Result<UIImage?,Error>>)
        ){
        
        let fetchPokemonsActivityIndicator = self.fetchPokemonsActivityIndicator
        isFetching = fetchPokemonsActivityIndicator.asDriver()
     
        let currentPokemons = PublishRelay<[PokemonUIDetails]>()
        let fetchPokemon = nextPageTrigger
            .withLatestFrom(currentPokemons.startWith([]))
            .map{$0.count}
            .map(getPokemonRequest)
            .flatMapLatest{ $0
                .asObservable()
                .trackActivity(fetchPokemonsActivityIndicator)
                .asResultsDriver()
            }
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let incomingPokemon = fetchPokemon.unwrapSuccess()
            .flatMapLatest{ pokemonResponse -> Driver<[PokemonUIDetails]> in
                Driver.combineLatest(pokemonResponse.results.map{
                    pokemon in
                        (pokemonImageRequest:getPokemonImage(pokemon.id), pokemon: pokemon)
                    }
                    .map{
                        info in
                        info.pokemonImageRequest
                            .unwrapSuccess()
                            .asDriver()
                            .map{
                                PokemonUIDetails(name: info.pokemon.name.capitalized, image: $0!, id:info.pokemon.id)
                            }
                })
            }.asDriver(onErrorDriveWith: Driver.empty())
        pokemonList = incomingPokemon
            .scan([], accumulator: { (existingValue, currentResponse) -> [PokemonUIDetails] in
                existingValue + currentResponse
            }).asDriver()
        
        pokemonList.asObservable().bind { (pokemonList) in
            currentPokemons.accept(pokemonList)
        }.disposed(by: disposeBag)
        
        error = fetchPokemon.unwrapError()
    }
    
}
