//
//  FilmsListViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class FilmsListViewController: UIViewController {
    
    var presenter: FilmsListPresenter?
    
    private let cellidentifire = "listFilms"
    
    private let searchTextFild: UITextField = {
        let searchTextFild = UITextField()
        searchTextFild.attributedPlaceholder = NSAttributedString(string: "Поиск фильмов",
                                                                  attributes: [.foregroundColor: UIColor.lightGray])
        searchTextFild.borderStyle = .roundedRect
        searchTextFild.layer.borderWidth = 1
        searchTextFild.layer.borderColor = UIColor.lightGray.cgColor
        searchTextFild.backgroundColor = .black
        searchTextFild.textColor = .white
        
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .lightGray
        
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        searchIcon.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        iconContainer.addSubview(searchIcon)
        
        searchTextFild.rightView = iconContainer
        searchTextFild.rightViewMode = .always
        
        return searchTextFild
    }()
    
    private let yearsPicker: UIPickerView = {
        let yearsPicker = UIPickerView()
        yearsPicker.backgroundColor = .black
        yearsPicker.layer.borderWidth = 1
        yearsPicker.layer.borderColor = UIColor.lightGray.cgColor
        return yearsPicker
    }()
    
    private let listFilmsTable: UITableView = {
        let listFilmsTable = UITableView()
        listFilmsTable.backgroundColor = .black
        return listFilmsTable
    }()
    
    private lazy var exitButton: UIBarButtonItem = {
        let image = UIImage(systemName: "xmark")?
            .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        return UIBarButtonItem(image: image,
                               style: .plain,
                               target: self,
                               action: #selector(tappedExit))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FilmsListPresenterImpl()
        view.backgroundColor = .black
        setupNavigationBar()
        setupDelegatePicker()
        setupUI()
        createListFilmsTable()
        tapGesture()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Кинопоиск"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .systemBlue
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = exitButton
    }
    
    private func setupUI() {
        view.addSubview(searchTextFild)
        view.addSubview(yearsPicker)
        view.addSubview(listFilmsTable)
        
        let topInset: CGFloat = 125
        let elementHeight: CGFloat = 44
        let horizontalPadding: CGFloat = 16
        let leftPadding: CGFloat = 50
        
        searchTextFild.frame = CGRect(
            x: leftPadding,
            y: topInset,
            width: view.bounds.width - leftPadding - horizontalPadding,
            height: elementHeight
        )
        
        yearsPicker.frame = CGRect(
            x: horizontalPadding,
            y: topInset + elementHeight + 8,
            width: view.bounds.width - 2 * horizontalPadding,
            height: elementHeight
        )
        
        listFilmsTable.frame = CGRect(
            x: 0,
            y: yearsPicker.frame.maxY + 8,
            width: view.bounds.width,
            height: view.bounds.height - yearsPicker.frame.maxY - view.safeAreaInsets.bottom
        )
    }
    
    @objc
    private func tappedExit() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    private func setupDelegatePicker() {
        yearsPicker.delegate = self
        yearsPicker.dataSource = self
        
        searchTextFild.delegate = self
        
    }
    
    private func createListFilmsTable() {
        listFilmsTable.register(CustomCell.self, forCellReuseIdentifier: CustomCell.filmCellIdentifier)
        listFilmsTable.dataSource = self
        listFilmsTable.delegate = self
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension FilmsListViewController: FilmsListView {
    
}

extension FilmsListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

extension FilmsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.films.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.filmCellIdentifier,
                                                       for: indexPath) as? CustomCell,
              let film = presenter?.films[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ячейка нажата \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let film = presenter?.films[indexPath.row] else { return }
        
        let detailFilmsVC = FilmDetailsViewController()
        let presenterFilmsVC = presenter?.makeFilmsDetailPresenter(film: film)
        
        detailFilmsVC.presenter = presenterFilmsVC
        presenterFilmsVC?.view = detailFilmsVC 
        
        navigationController?.pushViewController(detailFilmsVC, animated: true)
    }
}

extension FilmsListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextFild {
            searchTextFild.resignFirstResponder()
        }
        return true
    }
}
