//
//  FilmListResponce.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 20.04.2025.
//

import Foundation

struct FilmListResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalPages = "totalPages"
        case films = "items"
    }
    
    let total: Int
    let totalPages: Int
    let films: [Film]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decode(Int.self, forKey: .total)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        films = try container.decode([Film].self, forKey: .films)
    }
}
