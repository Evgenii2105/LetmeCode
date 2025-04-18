//
//  FilmDetailsPresenter.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import Foundation

protocol FilmDetailsPresenter: AnyObject {
    var film: Film { get }
}

protocol TapLinkDelegate: AnyObject {
    func tapLink()
}
