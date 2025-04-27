//
//  LoginViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: LoginPresenter?
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Кинопоиск"
        titleLabel.font = .systemFont(ofSize: 32)
        titleLabel.textColor = .cyan
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let userLogin: UITextField = {
        let userLogin = UITextField()
        userLogin.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [.foregroundColor: UIColor.gray]
        )
        userLogin.layer.cornerRadius = 8
        userLogin.borderStyle = .roundedRect
        userLogin.layer.borderWidth = 1
        userLogin.layer.borderColor = UIColor.gray.cgColor
        userLogin.backgroundColor = .black
        userLogin.textColor = .gray
        userLogin.translatesAutoresizingMaskIntoConstraints = false
        return userLogin
    }()
    
    private let userPassword: UITextField = {
        let userPassword = UITextField()
        userPassword.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [.foregroundColor: UIColor.gray]
        )
        userPassword.layer.cornerRadius = 8
        userPassword.borderStyle = .roundedRect
        userPassword.isSecureTextEntry = true
        userPassword.layer.borderWidth = 1
        userPassword.layer.borderColor = UIColor.gray.cgColor
        userPassword.backgroundColor = .black
        userPassword.textColor = .gray
        userPassword.translatesAutoresizingMaskIntoConstraints = false
        return userPassword
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        loginButton.backgroundColor = .cyan
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addHierarchy()
        setupContraints()
        setupAction()
        tapGesture()
        textFieldDelegate()
        setupNotifications()
    }
    
    private func addHierarchy() {
        // navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(userLogin)
        containerView.addSubview(userPassword)
        containerView.addSubview(loginButton)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            userLogin.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 160),
            userLogin.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            userLogin.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            userLogin.heightAnchor.constraint(equalToConstant: 44),
            
            userPassword.topAnchor.constraint(equalTo: userLogin.bottomAnchor, constant: 16),
            userPassword.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            userPassword.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            userPassword.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 64),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func textFieldDelegate() {
        userLogin.delegate = self
        userPassword.delegate = self
    }
    
    // MARK: - Actions
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
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc
    private func handleLogin() {
        presenter?.handleAuth(login: userLogin.text, password: userPassword.text)
    }
}

// MARK: UITextFieldDelegate
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
        
        navigationController?.pushViewController(filmsVC, animated: true)
    }
}

private extension LoginViewController {
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardSize.height
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardHeight
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
