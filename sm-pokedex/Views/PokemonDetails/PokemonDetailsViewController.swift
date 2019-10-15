//
//  PokemonDetailsController.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/25/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Braid

class PokemonDetailsController: UIViewController, UICollectionViewDelegateFlowLayout{
    private var pokemonViewModel: PokemonDetailsViewModel!
    
    public var pokemonNameLabel: UILabel!
    public var pokemonIdLabel: UILabel!
    public var pokemonWeightLabel : UILabel!
    public var pokemonHeightLabel : UILabel!
    public var typesCollection: UICollectionView!
    public var pokemonDescriptionLabel: UILabel!
    public var pokemonDetailsContainer: UIView!
    public var imageView: UIImageView!
    public var separator: UIView!
    
    
    let disposeBag = DisposeBag()
    
    init (pokemonVM: PokemonDetailsViewModel){
        super.init(nibName: nil, bundle: nil)
        pokemonViewModel = pokemonVM
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.pokemonViewModel.image
            .asObservable()
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        pokemonViewModel.name
            .asObservable()
            .bind(to: pokemonNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        pokemonViewModel.name
            .asObservable()
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        typesCollection.register(PokemonInformationCollectionCell.self, forCellWithReuseIdentifier: "cell")
        pokemonViewModel.pokemonTypes
            .asObservable()
            .bind(to: typesCollection.rx.items(cellIdentifier: "cell", cellType: PokemonInformationCollectionCell.self)){
                (row,model,cell) in
                cell.setUpWithViewModel(viewModel: PokemonInformationCellViewModel(type: model))
            }
            .disposed(by: self.disposeBag)
        
        pokemonViewModel.weight
            .asObservable()
            .bind(to: pokemonWeightLabel.rx.text)
            .disposed(by: disposeBag)
        pokemonViewModel.description
            .asObservable()
            .bind(to: pokemonDescriptionLabel.rx.text)
            .disposed(by: disposeBag )
        pokemonViewModel.id
            .asObservable()
            .bind(to: pokemonIdLabel.rx.text)
            .disposed(by: disposeBag )
        pokemonViewModel.height
            .asObservable()
            .bind(to: pokemonHeightLabel.rx.text)
            .disposed(by: disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //TODO find a way to make this dinamic
        return CGSize(width: 110, height: 60)
    }
}



