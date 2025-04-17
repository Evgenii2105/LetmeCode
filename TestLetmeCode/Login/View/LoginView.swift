//
//  LoginView.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol LoginView: AnyObject {
    func showError(message: String)
    func loginSucces()
    func clearFields()
}
