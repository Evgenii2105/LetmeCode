//
//  LoginPresenterImpl.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

class LoginPresenterImpl: LoginPresenter {
   
    weak var view: LoginView?
    
    private let userStorage: UserStorage
    
    init(userStrorage: UserStorage) {
        self.userStorage = userStrorage
    }
    
    func handleAuth(login: String?, password: String?) {
        guard let login = login?.trimmingCharacters(in: .whitespaces), !login.isEmpty,
              let password = password?.trimmingCharacters(in: .whitespaces), !password.isEmpty else {
            view?.showError(message: "Введите логин и пароль")
            return
        }
        
        switch  userStorage.validateUserPassword(login: login, password: password) {
            
        case .success:
            clearFields()
            view?.loginSucces()
        case .userNotFound:
            userStorage.saveLoginAndPasswordUser(login: login, password: password)
            clearFields()
            view?.loginSucces()
        case .wrongPassword:
            view?.showError(message: "Введите корректный пароль")
        }
    }
    
    func makeFilmsListPresenter() -> FilmsListPresenterImpl {
        return FilmsListPresenterImpl()
    }
    
    func clearFields() {
        view?.clearFields()
    }
}
