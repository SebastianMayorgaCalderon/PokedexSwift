//
//  PokemonUIListItem.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/1/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit

struct PokemonUIListItem {
    var id: String
    var name: String
    var url: String
    var image: UIImage?
    init(name: String, url: String, id: String) {
        self.name = name
        self.url = url
        self.id = id
    }
}
