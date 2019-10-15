//
//  DynamicTarget.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/11/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation
import Moya

public struct DynamicTarget: TargetType {
    public let baseURL: URL
    
    public var path: String { return token.path }
    
    public var method: Moya.Method { return token.method }
    
    public var sampleData: Data { return token.sampleData }
    
    public var task: Task { return token.task }
    
    public var headers: [String : String]? { return token.headers }
    
    let token: TargetType
}

