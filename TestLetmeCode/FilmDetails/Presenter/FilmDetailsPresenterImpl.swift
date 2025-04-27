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
        view?.showFilmDetails(cellTypes: filmDetails.toCellTypes())
    }
}
