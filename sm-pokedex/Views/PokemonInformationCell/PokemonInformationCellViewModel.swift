//
//  PokemonInformationCellViewModel.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/9/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PokemonInformationCellViewModel {
    private var pokemonTypeDriver: Driver<PokemonType>
    let pokemonType: Driver<String>
    
    init(type:PokemonType) {
        self.pokemonTypeDriver = Driver.of(type)
        self.pokemonType = pokemonTypeDriver.map{ $0.name }
    }
}
