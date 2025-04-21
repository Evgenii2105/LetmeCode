//
//  FilmDetailCellType.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 20.04.2025.
//

import Foundation

struct GenreItem {
    
    let genre: String
    
    init(genre: Genre) {
        self.genre = genre.genre
    }
}

struct CountryItem {
    
    let country: String
    
    init(country: Country) {
        self.country = country.country
    }
}

enum FilmDetailCellType {
    case movieHeaderPicture(image: URL)
    case description(link: URL?, description: String?)
    case genreAndYear(genres: [GenreItem], startYear: Int?, endYear: Int?, country: [CountryItem])
    case pictures(imageNames: [URL])
}
