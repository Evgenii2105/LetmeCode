//
//  FilmsListItem.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 20.04.2025.
//

import Foundation

struct FilmsListItem {
    
    let name: String?
    let countries: [CountryItem]
    let genres: [GenreItem]
    let ratingKinopoisk: Decimal
    let year: Int
    let posterUrlPreview: URL?
}
