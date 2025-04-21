//
//  Film.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

struct Film: Decodable {
    
    enum CodingKeys: String, CodingKey { // Сделано специально
        case kinopoiskId = "kinopoiskId"
        case imdbId = "imdbId"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case nameOriginal = "nameOriginal"
        case countries = "countries"
        case genres = "genres"
        case ratingKinopoisk = "ratingKinopoisk"
        case ratingImdb = "ratingImdb"
        case year = "year"
        case type = "type"
        case posterUrl = "posterUrl"
        case posterUrlPreview = "posterUrlPreview"
    }
    
    let kinopoiskId: Int
    let imdbId: String?
    let nameRu: String?
    let nameEn: String?
    let nameOriginal: String?
    let countries: [Country]
    let genres: [Genre]
    let ratingKinopoisk: Decimal
    let ratingImdb: Decimal?
    let year: Int
    let type: String
    let posterUrl: URL?
    let posterUrlPreview: URL?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kinopoiskId = try container.decode(Int.self, forKey: .kinopoiskId)
        self.imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        self.nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu)
        self.nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn)
        self.nameOriginal = try container.decodeIfPresent(String.self, forKey: .nameOriginal)
        self.countries = try container.decode([Country].self, forKey: .countries)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.ratingKinopoisk = try container.decode(Decimal.self, forKey: .ratingKinopoisk)
        self.ratingImdb = try container.decodeIfPresent(Decimal.self, forKey: .ratingImdb)
        self.year = try container.decode(Int.self, forKey: .year)
        self.type = try container.decode(String.self, forKey: .type)
        self.posterUrl = try container.decodeIfPresent(URL.self, forKey: .posterUrl)
        self.posterUrlPreview = try container.decodeIfPresent(URL.self, forKey: .posterUrlPreview)
    }
}

extension Film {
    
    func toListItem() -> FilmsListItem {
        return FilmsListItem(
            name: nameRu ?? nameEn ?? nameOriginal,
            countries: countries.map({ CountryItem(country: $0) }),
            genres: genres.map({ GenreItem(genre: $0) }),
            ratingKinopoisk: ratingKinopoisk,
            year: year,
            posterUrlPreview: posterUrlPreview as NSURL? as URL?
        )
    }
}
