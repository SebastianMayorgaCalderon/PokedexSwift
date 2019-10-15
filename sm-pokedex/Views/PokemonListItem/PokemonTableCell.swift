//
//  CustomTableViewCell.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/24/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PokemonTableCell: UITableViewCell {
    
    
    var label : UILabel!
    var mainImageView: UIImageView!
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 100
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(stackView)

        mainImageView = UIImageView()
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(mainImageView)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            mainImageView.widthAnchor.constraint(equalToConstant: 90),
            mainImageView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func setUpWithViewModel(viewModel : PokemonTableCellViewModel){
        viewModel.image
            .asObservable()
            .bind(to: mainImageView!.rx.image)
            .disposed(by: disposeBag)
        viewModel.name
            .asObservable()
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        self.mainImageView.layoutIfNeeded()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

