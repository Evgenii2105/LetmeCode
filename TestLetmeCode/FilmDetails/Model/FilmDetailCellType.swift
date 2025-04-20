//
//  FilmDetailCellType.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 20.04.2025.
//

import Foundation

struct GenreItem {
    
    let genre: String
    
    init(genre: Film.Genre) {
        self.genre = genre.genre
    }
}

struct CountryItem {
    
    let country: String
    
    init(country: Film.Country) {
        self.country = country.country
    }
}

enum FilmDetailCellType {
    case description(text: String, link: URL?)
    case genreAndYear(genres: [GenreItem], year: Int, country: [CountryItem])
    case pictures(imageNames: [String])
}
