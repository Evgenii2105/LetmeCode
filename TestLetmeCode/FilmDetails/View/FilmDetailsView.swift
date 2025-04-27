//
//  FilmDetailsView.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import Foundation

protocol FilmDetailsView: AnyObject {
    func showFilmDetails(cellTypes: [FilmDetailCellType])
}
