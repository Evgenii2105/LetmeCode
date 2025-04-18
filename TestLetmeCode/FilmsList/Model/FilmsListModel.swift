//
//  FilmsListModel.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

struct Film {
    let title: String
    let genre: String
    let year: Decimal
    let country: String
    let rating: Decimal
    
    enum FildDetailCellType {
        case description(text: String, link: URL?)
        case genreAndYear(genre: String, year: Decimal)
        case pictures(imageNames: [String])
    }
}

extension Film {
    
    func toCellTypes() -> [FildDetailCellType] {
        return [
            .description(text: "Описание фильма", link: nil),
            .genreAndYear(genre: genre, year: year),
            .pictures(imageNames: [])
        ]
    }
}
