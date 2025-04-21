//
//  FilmDetailsPresenter.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import Foundation

protocol FilmDetailsPresenter: AnyObject {
    func setupDataSourse()
}

protocol TapLinkDelegate: AnyObject {
    func tapLink()
}
