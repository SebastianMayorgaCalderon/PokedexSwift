//
//  ViewController.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 6/24/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Braid

class PokemonTableViewController: UIViewController{
   
    @IBOutlet weak var appTitleLabel: UILabel!
    public var tableView: UITableView!
    public var binder: TableViewBinder!
    public var pokemonViewModel: PokemonTableViewModel!
    public let disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        pokemonViewModel = PokemonTableViewModel(
            getPokemonRequest: { offset in
                GetPokemonsRequest(offset: offset)
                .execute(in: Dispatcher.shared!)
            },
            getPokemonImage: {pokemonId in
                GetPokemonImageRequest(id: pokemonId)
                .execute(in: Dispatcher.shared!)
            }
        )
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        
        self.binder = TableViewBinder(tableView: self.tableView)
        self.binder.onTable().rx
            .bind(cellType: PokemonTableCell.self, models: self.pokemonViewModel.pokemonList.asObservable())
            .onDequeue{(row: Int, cell: PokemonTableCell, pokemon: PokemonUIDetails) in
                cell.setUpWithViewModel(
                    viewModel: PokemonTableCellViewModel(pokemon: pokemon)
                )
            }.onTapped{(row: Int, cell: PokemonTableCell, pokemon: PokemonUIDetails) in
                let pokemonDetailsVM = PokemonDetailsViewModel(
                pokemon: Pokemon(id: pokemon.id, name: pokemon.name, types: [], description: [], height: nil, weight: nil, image: pokemon.image),
                getPokemonDetails: {
                    GetPokemonDetailsRequest(
                        id: $0
                    ).execute(in: Dispatcher.shared!)
                },
                getPokemonSpecieDetails: {
                    GetPokemonSpecieRequest(
                        id: $0
                    ).execute(in: Dispatcher.shared!)
                }
                )
                let newView = PokemonDetailsController(pokemonVM: pokemonDetailsVM)
                self.navigationController?.pushViewController(newView, animated: true)
            }
        binder.finish()

        self.tableView.rx.reachedBottom
            .withLatestFrom(pokemonViewModel.fetchPokemonsActivityIndicator.asDriver())
            .filter{ !$0 }
            .map{ _ in () }
            .startWith(())
            .bind(to: pokemonViewModel.nextPageTrigger)
            .disposed(by: disposeBag)
        
        self.appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.appTitleLabel.text = pokemonViewModel.appTitle
        
        self.pokemonViewModel.error.drive(onNext: { error in
            print(error)
        }).disposed(by: disposeBag)
        
    }
} 
