//
//  FilmsListPresenter.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol FilmsListPresenter: AnyObject {
    var films: [Film] { get }
    func makeFilmsDetailPresenter(film: Film) -> FilmDetailsPresenterImpl
}
