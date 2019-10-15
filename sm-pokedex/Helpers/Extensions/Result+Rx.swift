//
//  Result+Rx.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/11/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result
import RxOptional

extension ObservableConvertibleType {
    // TODO: Error type?
    func asResultsDriver() -> Driver<Result<E,Error>> {
        return self
            .asObservable()
            .map{ Result.success($0) }
            .asDriver(onErrorRecover: { (internalError: Error) in Driver.just(Result<E,Error>.failure(internalError)) })
    }
}

extension ObservableConvertibleType where E: ResultProtocol,E.Error == Error {
    // TODO: Error type?
    func asResultsDriver() -> Driver<E> {
        return self
            .asObservable()
            .asDriver(onErrorRecover: { (internalError: Error) in Driver.just(E.init(error: internalError)) })
    }
}


extension SharedSequenceConvertibleType where E: ResultProtocol {
    public func `do`(onSuccess: ((E.Value) -> Void)? = nil, onFailure: ((E.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onSubscribe: (() -> ())? = nil, onSubscribed: (() -> ())? = nil, onDispose: (() -> ())? = nil) -> SharedSequence<SharingStrategy, E> {
        return self.do(onNext: { result in
            result.analysis(ifSuccess: { value in
                onSuccess?(value)
            }, ifFailure: { error in
                onFailure?(error)
            })
        }, onCompleted: onCompleted, onSubscribe: onSubscribe, onSubscribed: onSubscribed, onDispose: onDispose)
    }
    
    func filterSuccess() -> SharedSequence<SharingStrategy, E> {
        return self.filter{ $0.value != nil }
    }
    
    func filterFailure() -> SharedSequence<SharingStrategy, E> {
        return self.filter{ $0.error != nil }
    }
    
    func filterSuccess(_ predicate: @escaping (E.Value) -> Bool) -> SharedSequence<SharingStrategy, E> {
        return self.filter{ result in
            return result.analysis(
                ifSuccess: predicate,
                ifFailure: { _ in false }
            )
        }
    }
}

extension SharedSequence where Element: ResultProtocol {
    func mapSuccess<R>(_ selector: @escaping (Element.Value) -> R) -> SharedSequence<S, Result<R,Element.Error>> {
        return self.map{ result in
            return result.analysis(ifSuccess: { value in
                return Result.success(selector(value))
                
            }, ifFailure: { error in
                return Result.failure(error)
            })
        }
    }
    
    func checkSuccess(_ selector: @escaping (Element.Value) -> (Element.Error?)) -> SharedSequence<S, Result<Element.Value,Element.Error>> {
        return self.map{ result in
            return result.analysis(ifSuccess: { value in
                guard let error = selector(value) else {
                    return Result.success(value)
                }
                return Result.failure(error)
            }, ifFailure: { error in
                return Result.failure(error)
            })
        }
    }
    
    func map<R>(success: @escaping (Element.Value)->R, failure: @escaping (Element.Error)->R) -> SharedSequence<S, R> {
        return self.map{ result in
            return result.analysis(ifSuccess: { value in
                return success(value)
                
            }, ifFailure: { error in
                return failure(error)
            })
        }
    }
}

extension SharedSequence where S == DriverSharingStrategy, Element: ResultProtocol {
    func drive(onSuccess: ((Element.Value) -> Void)? = nil, onFailure: ((Element.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        return self.drive(onNext: { result in
            result.analysis(ifSuccess: { value in
                onSuccess?(value)
            }, ifFailure: { error in
                onFailure?(error)
            })
        }, onCompleted: onCompleted, onDisposed: onDisposed)
    }
    
    func unwrapSuccess() -> SharedSequence<SharingStrategy, E.Value> {
        return self.map{ $0.value }
            .filterNil()
    }
    
    func unwrapError() -> SharedSequence<SharingStrategy, E.Error> {
        return self.map{ $0.error }
            .filterNil()
    }
    
    func unwrap() -> Observable<E.Value> {
        return self.asObservable()
            .flatMapLatest{ result -> Observable<E.Value> in
                if let value = result.value {
                    return Observable.just(value)
                } else {
                    let error = result.error
                    return Observable.error(error!)
                }
        }
    }
}
