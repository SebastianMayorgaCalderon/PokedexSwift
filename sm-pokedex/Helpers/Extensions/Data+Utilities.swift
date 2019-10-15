//
//  Data+Utilities.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 9/11/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation

extension Data {
    init(from json: String) {
        let validFileName = json.hasSuffix(".json") ? json.replacingOccurrences(of: ".json", with: "") : json
        guard let jsonUrl = Bundle.main.url(forResource: validFileName, withExtension: "json") else {
            self.init()
            return
        }
        do {
            try self.init(contentsOf: jsonUrl)
        } catch {
            self.init()
        }
    }
    
    static func generateRandomBitsKey(length: Int) -> Data? {
        var result:Data? = nil
        if let keyData = NSMutableData(length: length) {
            _ = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
            result = keyData as Data
        }
        return result
    }
}

