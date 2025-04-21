//
//  Country.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 21.04.2025.
//

import Foundation

struct Country: Decodable {
    
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
    }
}
