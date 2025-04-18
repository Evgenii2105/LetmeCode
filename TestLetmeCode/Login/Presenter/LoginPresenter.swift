//
//  LoginPresenter.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol LoginPresenter {
    func handleAuth(login: String?, password: String?)
    func makeFilmsListPresenter() -> FilmsListPresenterImpl
}
