//
//  FilmDetailsPresenterImpl.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class FilmDetailsPresenterImpl: FilmDetailsPresenter {
    
    weak var view: FilmDetailsView?
    
    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    func setupDataSourse() {
//        let title = film.title
//        let rating = film.rating
//        let cellTypes = film.toCellTypes()

       // view?.showFilmDetails(title: title, rating: rating, cellTypes: cellTypes)
    }
}
