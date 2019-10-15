//
//  PokemonTableCellViewModel.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/4/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Result

class PokemonTableCellViewModel {
    
    private var pokemonDriver: Driver<PokemonUIDetails>
    
    var image : Driver<UIImage?>
    let name :Driver<String>
    
    init(pokemon: PokemonUIDetails){
        pokemonDriver = Driver.of(pokemon)
        
        self.name = pokemonDriver.map{ $0.name }
        self.image = pokemonDriver.map{ $0.image }
    
    }
}
