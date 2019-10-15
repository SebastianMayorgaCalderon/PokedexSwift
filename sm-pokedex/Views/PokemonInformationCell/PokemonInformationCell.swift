//
//  PokemonInformationCell.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/27/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class PokemonInformationCollectionCell: UICollectionViewCell {
    
    var typeLabel : UILabel!
    var disposebag = DisposeBag()
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(stackView)

        self.typeLabel = UILabel()
        self.typeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(typeLabel)

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setUpWithViewModel(viewModel: PokemonInformationCellViewModel) {
        viewModel.pokemonType
            .asObservable()
            .bind(to: typeLabel.rx.text)
            .disposed(by: disposebag)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
