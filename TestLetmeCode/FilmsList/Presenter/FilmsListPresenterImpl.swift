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
    private let dataManagerService: DataManagerService = DataManagerServiceImpl()
    private var films: [Film] = []
    
    
    func makeFilmsDetailPresenter(at index: Int) {
        if index < films.count {
            dataManagerService.getFilmDetails(filmId: films[index].kinopoiskId) { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let filmDetails):
                        let presenter = FilmDetailsPresenterImpl(filmDetails: filmDetails)
                        self.view?.didConfigureDetailsPresenter(detailsPresenter: presenter)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } else {
            fatalError()
        }
    }
    
    func performLogaut() {
        delegate?.didLogout()
    }
    
    func setupDataSource() {
        dataManagerService.getFilms { [weak self] result in
            switch result {
            case .success(let films):
                self?.films = films
                self?.view?.didLoadFilms(films: films.map({ $0.toListItem() }))
            case .failure(let error):
                print(error)
            }
        }
    }
}
