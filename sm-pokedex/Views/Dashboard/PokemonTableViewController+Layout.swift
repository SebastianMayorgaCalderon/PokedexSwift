//
//  PokemonTableViewController+Layout.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/5/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import UIKit

extension PokemonTableViewController {
    func createUI(){
        
        tableView = UITableView(frame: self.view.frame)
        tableView.frame = self.view.frame
        self.tableView.register(PokemonTableCell.self)
        self.tableView.isScrollEnabled = true
        self.view.addSubview(tableView)
        
        self.appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
    }
}
