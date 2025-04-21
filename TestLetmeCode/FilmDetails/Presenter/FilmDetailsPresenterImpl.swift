//
//  FilmDetailsPresenterImpl.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class FilmDetailsPresenterImpl: FilmDetailsPresenter {
    
    weak var view: FilmDetailsView?
    
    private let filmDetails: FilmDetails
    
    init(filmDetails: FilmDetails) {
        self.filmDetails = filmDetails
    }
    
    func setupDataSourse() {
        
        let title =  [
            filmDetails.nameOriginal,
            filmDetails.nameEn,
            filmDetails.nameRu
        ]
            .compactMap({ $0 })
            .filter({ !$0.isEmpty })
            .first
        
        view?.showFilmDetails(
            title: title ?? "Без названия",
            rating: filmDetails.ratingKinopoisk,
            cellTypes: filmDetails.toCellTypes(),
            imageUrl: filmDetails.coverUrl
        )
        
//        let movie = film.posterUrl
//        let title =  [
//            film.nameOriginal,
//            film.nameEn,
//            film.nameRu
//        ]
//            .compactMap({ $0 })
//            .filter({ !$0.isEmpty })
//            .first
//        let rating = film.ratingKinopoisk
//        let cellTypes = film.toCellTypes()
//        let detailMovie = film.posterUrl
//        
//        view?.showFilmDetails(
//            title: title ?? "",
//            rating: rating,
//            cellTypes: cellTypes,
//            imageUrl: movie,
//            imagePreview: detailMovie
//        )
    }
}
