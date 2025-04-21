//
//  Genre.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 21.04.2025.
//

import Foundation

struct Genre: Decodable {
    
    let genre: String
    
    enum CodingKeys: String, CodingKey {
        case genre = "genre"
    }
}
