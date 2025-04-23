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
    private var films: [FilmsListItem] = []
    
    func makeFilmsDetailPresenter(film: FilmsListItem) {
        dataManagerService.getFilmDetails(filmId: film.kinopoiskId) { [weak self] result in
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
    }
    
    func performLogaut() {
        delegate?.didLogout()
    }
    
    func setupDataSource() {
        dataManagerService.getFilms { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.films = films.map({ $0.toListItem() })
                    self.view?.didLoadFilms(films: self.films)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func search(with query: String?) {
        guard let query = query, !query.isEmpty else {
            view?.didLoadFilms(films: films)
            return
        }
        let queryLow = query.lowercased()
        
        let filterFilms = films.filter({ film in
            let filterByName = film.name?.lowercased().contains(queryLow) ?? false
            let filterByGenre = film.genres.contains(where: { $0.genre.contains(queryLow) })
            let filterByCountry = film.countries.contains(where: { $0.country.contains(queryLow) })
            
            return filterByName || filterByGenre || filterByCountry
        })
        view?.didLoadFilms(films: filterFilms)
    }
    
    func sort(by: FilmsListViewController.Sorted) {
        var sorted = films
        switch by {
        case .sortedDefault:
            break
        case .sortedDescending:
            sorted = films.sorted(by: { $0.ratingKinopoisk > $1.ratingKinopoisk })
        case .sortedAscending:
            sorted = films.sorted(by: { $0.ratingKinopoisk < $1.ratingKinopoisk })
        }
        view?.didLoadFilms(films: sorted)
    }
    
    func filter(by year: GenericPickerViewController.YearFilter) {
        var filterFilms = films
        switch year {
        case .allYears:
            break
        case .specificYear(let year):
            filterFilms = films.filter({ $0.year == year })
        }
        view?.didLoadFilms(films: filterFilms)
    }
}
