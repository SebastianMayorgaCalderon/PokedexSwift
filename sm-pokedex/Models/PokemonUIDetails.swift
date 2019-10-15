//
//  PokemonUIDetails.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/1/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
struct PokemonUIDetails {
    var name: String
    var image: UIImage
    var id: Int
    init(name: String, image:UIImage, id: Int) {
        self.name = name
        self.image = image
        self.id = id
    }
}
