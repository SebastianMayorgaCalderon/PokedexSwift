//
//  ApiModels.swift
//  sm-pokedex
//
//  Created by Sebastian Mayorga on 7/18/19.
//  Copyright © 2019 Sebastian Mayorga. All rights reserved.
//

import Foundation

public extension PokemonAPI {
    struct Model {
        public struct Base {
            public let id: Int
            public let name: String
            public let height: Int
            public let weight: Int
            public let type: String
        }
        
        public struct Species {
            public let color: String
            public let description: String
        }
    }
}

extension PokemonAPI.Model.Base: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case type = "types"
    }
    
    private struct TypeContainer: Codable {
        let type: TypeDetails
    }
    
    private struct TypeDetails: Codable {
        let name: String
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let height = try container.decode(Int.self, forKey: .height)
        let weight = try container.decode(Int.self, forKey: .weight)
        guard let type = try container.decode([TypeContainer].self, forKey: .type).first?.type.name else {
            throw NSError(domain: "asdf", code: 1, userInfo: nil)
        }
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.type = type
    }
}

extension PokemonAPI.Model.Species: Codable {
    enum CodingKeys: String, CodingKey {
        case color
        case description = "flavor_text_entries"
    }
    
    private struct Details: Codable {
        let name: String
        let url: String
    }
    
    private  struct Description: Codable {
        let flavor_text: String
        let language: Details
        let version: Details
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let color = try container.decode(Details.self, forKey: .color).name
        guard let description = try container.decode([Description].self, forKey: .description)
            .first(where: { $0.language.name == "en" })?
            .flavor_text
            .replacingOccurrences(of: "\n", with: " ")
            else {
                throw NSError(domain: "asdf", code: 1, userInfo: nil)
        }
        self.color = color
        self.description = description
    }
}
