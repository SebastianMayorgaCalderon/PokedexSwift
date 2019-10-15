//
//  PokemonDetailViewController+Layout.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/5/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import UIKit

extension PokemonDetailsController {
    func createUI(){
        view.backgroundColor = .white
        
        self.pokemonDetailsContainer = UIView()
        self.pokemonDetailsContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pokemonDetailsContainer)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonDetailsContainer.addSubview(imageView)
        
        pokemonNameLabel = UILabel()
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.font = pokemonNameLabel.font.withSize(50)
        pokemonDetailsContainer.addSubview(pokemonNameLabel)
        
        separator = UIView()
        separator.backgroundColor = .black
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.layer.borderColor = UIColor.black.cgColor
        pokemonDetailsContainer.addSubview(separator)
        
        let layout = UICollectionViewFlowLayout()
        
        typesCollection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        typesCollection.translatesAutoresizingMaskIntoConstraints = false
        typesCollection.backgroundColor = .white
        typesCollection.rx.setDelegate(self).addDisposableTo(disposeBag)
        view.addSubview(typesCollection)
        
        let pokemonStatsContainer = UIStackView()
        pokemonStatsContainer.spacing = 5
        pokemonStatsContainer.axis = .vertical
        pokemonStatsContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pokemonStatsContainer)
        
        pokemonIdLabel = UILabel()
        pokemonStatsContainer.addArrangedSubview(pokemonIdLabel)
        
        pokemonWeightLabel = UILabel()
        pokemonStatsContainer.addArrangedSubview(pokemonWeightLabel)
        pokemonWeightLabel.textAlignment = .center
        pokemonWeightLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        
        pokemonHeightLabel = UILabel()
        pokemonStatsContainer.addArrangedSubview(pokemonHeightLabel)
        pokemonHeightLabel.textAlignment = .center
        pokemonHeightLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        
        pokemonDescriptionLabel = UILabel()
        pokemonStatsContainer.addArrangedSubview(pokemonDescriptionLabel)
        pokemonDescriptionLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        pokemonDescriptionLabel.numberOfLines = 8
        pokemonDescriptionLabel.font = pokemonDescriptionLabel.font.withSize(18)
        
        NSLayoutConstraint.activate([
            pokemonDetailsContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailsContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            pokemonDetailsContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            imageView.topAnchor.constraint(equalTo: pokemonDetailsContainer.topAnchor),
            imageView.leftAnchor.constraint(equalTo: pokemonDetailsContainer.leftAnchor, constant: 80),
            imageView.rightAnchor.constraint(equalTo: pokemonDetailsContainer.rightAnchor, constant: -80),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            pokemonNameLabel.leftAnchor.constraint(equalTo: pokemonDetailsContainer.leftAnchor, constant: 20),
            pokemonNameLabel.rightAnchor.constraint(equalTo: pokemonDetailsContainer.rightAnchor),
            pokemonNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            separator.leftAnchor.constraint(equalTo: pokemonDetailsContainer.leftAnchor, constant: 20),
            separator.rightAnchor.constraint(equalTo: pokemonDetailsContainer.rightAnchor, constant: -20),
            separator.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            pokemonDetailsContainer.bottomAnchor.constraint(equalTo: separator.bottomAnchor),
            
            typesCollection.topAnchor.constraint(equalTo: pokemonDetailsContainer.bottomAnchor, constant: 20),
            typesCollection.heightAnchor.constraint(equalToConstant: 70),
            typesCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            typesCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            pokemonStatsContainer.topAnchor.constraint(equalTo:typesCollection.bottomAnchor),
            pokemonStatsContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            pokemonStatsContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}



