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
    
    func makeFilmsDetailPresenter(film: Film) -> FilmDetailsPresenterImpl {
        return FilmDetailsPresenterImpl(film: film)
    }
    
    func performLogaut() {
        delegate?.didLogout()
    }
    
    func setupDataSource() {
        dataManagerService.getFilms { [weak self] result in
            switch result {
            case .success(let films):
                self?.view?.didLoadFilms(films: films.map({ $0.toListItem() }))
            case .failure(let error):
                print(error)
            }
        }
    }
}
