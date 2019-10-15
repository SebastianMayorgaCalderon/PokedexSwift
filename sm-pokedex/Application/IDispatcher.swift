//
//  IDispatcher.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/11/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//


import Foundation
import RxSwift
import Moya

public typealias ITarget = TargetType

public protocol IDispatcher {
    
    /// Returns an observable with the given `request`
    func execute(_ request: ITarget) -> Single<Response>
}

extension ITarget {
    public var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
}
