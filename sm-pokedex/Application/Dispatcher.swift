//
//  Dispatcher.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/11/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//


import Foundation
import RxSwift
import Moya
import Alamofire


public class Dispatcher: IDispatcher {
    typealias EndpointClosure = (MultiTarget) -> Endpoint<MultiTarget>
    
    static var shared: Dispatcher?
    
    private let provider: MoyaProvider<MultiTarget>
    private let retryObs = Observable.just(1)
    private let retryLock = NSRecursiveLock()
    
    public required init() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint<MultiTarget> in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return endpoint.adding(newHTTPHeaderFields: [:])
        }
        provider = MoyaProvider(
            endpointClosure: endpointClosure,
            plugins: [NetworkLoggerPlugin(verbose: true)]
        )
    }
    
    public func execute(_ request: ITarget) -> Single<Response> {
        let target = DynamicTarget(baseURL: request.baseURL, token: request )
        return provider.rx.request(MultiTarget(target))
    }
}
