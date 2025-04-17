//
//  LoginViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Кинопоиск"
        titleLabel.font = .systemFont(ofSize: 32)
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let userLogin: UITextField = {
        let userLogin = UITextField()
        userLogin.placeholder = "Логин"
        userLogin.borderStyle = .roundedRect
        userLogin.translatesAutoresizingMaskIntoConstraints = false
        return userLogin
    }()
    
    private let userPassword: UITextField = {
        let userPassword = UITextField()
        userPassword.placeholder = "Пароль"
        userPassword.borderStyle = .roundedRect
        userPassword.isSecureTextEntry = true
        userPassword.translatesAutoresizingMaskIntoConstraints = false
        return userPassword
    }()
    
    private let loginBitton: UIButton = {
        let loginBitton = UIButton(type: .system)
        loginBitton.setTitle("Войти", for: .normal)
        loginBitton.setTitleColor(.white, for: .normal)
        loginBitton.backgroundColor = .systemBlue
        loginBitton.layer.cornerRadius = 8
        loginBitton.translatesAutoresizingMaskIntoConstraints = false
        return loginBitton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addHierarchy()
        setupContraints()
        setupAction()
        tapGesture()
        textFieldDelegate()
    }

    private func addHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(userLogin)
        view.addSubview(userPassword)
        view.addSubview(loginBitton)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userLogin.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 160),
            userLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userLogin.heightAnchor.constraint(equalToConstant: 44),
            
            userPassword.topAnchor.constraint(equalTo: userLogin.bottomAnchor, constant: 16),
            userPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userPassword.heightAnchor.constraint(equalToConstant: 44),
            
            loginBitton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 240),
            loginBitton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            loginBitton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            loginBitton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    private func textFieldDelegate() {
        userLogin.delegate = self
        userPassword.delegate = self
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         view.addGestureRecognizer(tapGesture)
    }
    
    private func saveLoginAndPasswordUser() {
        guard let userLoginn = userLogin.text, !userLoginn.isEmpty,
              let userPasswordd = userPassword.text, !userPasswordd.isEmpty else {
                  return
              }
        UserDefaults.standard.set(userLoginn, forKey: userPasswordd)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupAction() {
        loginBitton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc
    private func handleLogin() {
        presenter?.handleAuth(login: userLogin.text, password: userPassword.text)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userLogin {
            userPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginView {
    
    func clearFields() {
        userLogin.text = ""
        userPassword.text = ""
    }
    
    func showError(message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func loginSucces() {
        let filmsVC = FilmsListViewController()
        let filmsListPresenter = presenter?.makeFilmsListPresenter()
        
        filmsVC.presenter = filmsListPresenter
        filmsListPresenter?.view = filmsVC
        
        navigationController?.pushViewController(FilmsListViewController(), animated: true)
    }
}
