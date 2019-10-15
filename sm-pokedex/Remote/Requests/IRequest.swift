//
//  IRequest.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/11/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result
import Moya

let requestDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
}()

protocol IRequest: ITarget {
    associatedtype OutputType
    
    /// Executes the `target` in the given dispatcher and returns
    /// a Single observable with the parse response
    func execute(in dispatcher: IDispatcher) -> Driver<Result<OutputType,Error>>
}

extension IRequest where OutputType: Decodable {
    func execute(in dispatcher: IDispatcher) -> Driver<Result<OutputType,Error>> {
        return dispatcher.execute(self)
            .filterSuccessfulStatusCodes()
            .map(OutputType.self, using: requestDecoder)
            .asResultsDriver()
    }
}

extension IRequest where OutputType == UIImage? {
    var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/")!
    }
    func execute(in dispatcher: IDispatcher) -> Driver<Result<OutputType,Error>> {
        return dispatcher.execute(self)
            .filterSuccessfulStatusCodes()
            .mapImage()
            .asResultsDriver()
    }
}

