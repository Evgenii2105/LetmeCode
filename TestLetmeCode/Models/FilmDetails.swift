//
//  FilmDetails.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 21.04.2025.
//

import Foundation

struct FilmDetails: Decodable {
    
    let nameOriginal: String?
    let filmDescription: String?
    let countries: [Country]
    let genre: [Genre]
    let startYear: Int?
    let endYear: Int?
    let ratingKinopoisk: Decimal
    let coverUrl: URL?
    let nameRu: String?
    let nameEn: String?
        
    enum CodingKeys: String, CodingKey {
        case nameOriginal = "nameOriginal"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case filmDescription = "description"
        case countries = "countries"
        case genres = "genres"
        case startYear = "startYear"
        case endYear = "endYear"
        case ratingKinopoisk = "ratingKinopoisk"
        case coverUrl = "coverUrl"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameOriginal = try container.decodeIfPresent(String.self, forKey: .nameOriginal)
        nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu)
        nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn)
        filmDescription = try container.decodeIfPresent(String.self, forKey: .filmDescription)
        countries = try container.decode([Country].self, forKey: .countries)
        genre = try container.decode([Genre].self, forKey: .genres)
        startYear = try container.decodeIfPresent(Int.self, forKey: .startYear)
        endYear = try container.decodeIfPresent(Int.self, forKey: .endYear)
        ratingKinopoisk = try container.decode(Decimal.self, forKey: .ratingKinopoisk)
        coverUrl = try container.decodeIfPresent(URL.self, forKey: .coverUrl)
    }
}

extension FilmDetails {
    
    func toCellTypes() -> [FilmDetailCellType] {
        return [
            .description(link: nil,
                         description: filmDescription),
            .genreAndYear(genres: genre.map({ GenreItem(genre: $0) }),
                          startYear: startYear,
                          endYear: endYear,
                          country: countries.map({ CountryItem(country: $0) })),
            .pictures(imageNames: [coverUrl].compactMap({ $0 }))
        ]
    }
}
