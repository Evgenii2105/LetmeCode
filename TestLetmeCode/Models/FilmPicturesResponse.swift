//
//  FilmPicturesResponse.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 26.04.2025.
//

import Foundation

struct FilmPicturesResponse: Decodable {
    
    struct Items: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case imageUrl = "imageUrl"
            case previewUrl = "previewUrl"
        }
        
        let imageUrl: URL?
        let previewUrl: URL?
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.imageUrl = try container.decodeIfPresent(URL.self, forKey: .imageUrl)
            self.previewUrl = try container.decodeIfPresent(URL.self, forKey: .previewUrl)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case total = "total"
        case totalPages = "totalPages"
        case items = "items"
    }
    
    let total: Int
    let totalPages: Int
    let items: [Items]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(Int.self, forKey: .total)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.items = try container.decode([FilmPicturesResponse.Items].self, forKey: .items)
    }
}
