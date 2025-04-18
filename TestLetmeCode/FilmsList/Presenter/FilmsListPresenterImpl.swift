//
//  FilmsListPresenterImpl.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class FilmsListPresenterImpl: FilmsListPresenter {
   
    weak var view: FilmsListView?
    
    weak var delegate: FilmsListDelegate?
   
    var films: [Film] = [
        Film(title: "Во все тяжкие", genre: "драма", year: 2008, country: "США", rating: 9.5),
        Film(title: "Друзья", genre: "комедия", year: 1998, country: "USA", rating: 9.8)
    ]
    
    func makeFilmsDetailPresenter(film: Film) -> FilmDetailsPresenterImpl {
        return FilmDetailsPresenterImpl(film: film)
    }
    
    func performLogaut() {
        delegate?.didLogout()
    }
}
