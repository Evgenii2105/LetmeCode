//
//  FilmsListPresenter.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol FilmsListPresenter: AnyObject {
    func makeFilmsDetailPresenter(film: FilmsListItem)
    func performLogaut()
    func setupDataSource()
    func search(with query: String?)
    func sort(by: FilmsListViewController.FilmSorting)
    func filter(by year: GenericPickerViewController.YearFilter)
}

protocol FilmsListDelegate: AnyObject {
    func didLogout()
}
