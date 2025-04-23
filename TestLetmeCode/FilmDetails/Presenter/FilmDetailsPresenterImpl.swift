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
            imageUrl: filmDetails.posterUrl
        )
    }
}
