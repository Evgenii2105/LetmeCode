//
//  FilmsListPresenter.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol FilmsListPresenter: AnyObject {
    func makeFilmsDetailPresenter(film: Film) -> FilmDetailsPresenterImpl
    func performLogaut()
    func setupDataSource()
}

protocol FilmsListDelegate: AnyObject {
    func didLogout()
}
