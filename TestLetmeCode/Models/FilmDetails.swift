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
    let posterUrl: URL?
    let nameRu: String?
    let nameEn: String?
    let year: Int?
    let webUrl: URL?
    var pictures: [FilmPicturesResponse.Items] = []
    
    enum CodingKeys: String, CodingKey {
        case nameOriginal = "nameOriginal"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case filmDescription = "description"
        case countries = "countries"
        case genres = "genres"
        case startYear = "startYear"
        case endYear = "endYear"
        case year = "year"
        case ratingKinopoisk = "ratingKinopoisk"
        case coverUrl = "coverUrl"
        case posterUrl = "posterUrl"
        case webUrl = "webUrl"
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
        posterUrl = try container.decodeIfPresent(URL.self, forKey: .posterUrl)
        year = try container.decodeIfPresent(Int.self, forKey: .year)
        webUrl = try container.decodeIfPresent(URL.self, forKey: .webUrl)
    }
}

extension FilmDetails {
    
    func toCellTypes() -> [FilmDetailCellType] {
        return [
            .movieHeaderPicture(
                imageURl: posterUrl,
                name: nameOriginal ?? nameRu ?? nameEn,
                rating: ratingKinopoisk
            ),
            .description(
                link: webUrl,
                description: filmDescription
            ),
            .genreAndYear(genres: genre.map({ GenreItem(genre: $0) }),
                          startYear: startYear,
                          endYear: endYear,
                          country: countries.map({ CountryItem(country: $0) }),
                          year: year),
            .pictures(imageNames: pictures.compactMap({ $0.previewUrl }))
        ]
    }
}
