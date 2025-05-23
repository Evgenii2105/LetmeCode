//
//  FilmsListView.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol FilmsListView: AnyObject {
    func didLoadFilms(films: [FilmsListItem])
    func didConfigureDetailsPresenter(detailsPresenter: FilmDetailsPresenterImpl)
}
