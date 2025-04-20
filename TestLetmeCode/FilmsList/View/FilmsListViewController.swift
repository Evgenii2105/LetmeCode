//
//  FilmsListViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class FilmsListViewController: UIViewController {
    
    enum Sorted {
        case sortedDefault
        case sortedDescending
        case sortedAscending
    }
    
    // MARK: - Properties
    var presenter: FilmsListPresenter?
    private var currentSorted: Sorted = .sortedDefault
    private var films: [FilmsListItem] = []
    
    // MARK: - UI Components
    private let searchTextFild: UITextField = {
        let searchTextFild = UITextField()
        searchTextFild.attributedPlaceholder = NSAttributedString(
            string: "Поиск фильмов",
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
    
    private lazy var yearButton: UIButton = {
        let yearButton = UIButton()
        let image = UIImage(systemName: "chevron.down")
        yearButton.setTitle("Фильмы по годам", for: .normal)
        yearButton.setImage(image, for: .normal)
        yearButton.setTitleColor(.white, for: .normal)
        yearButton.backgroundColor = .black
        yearButton.layer.borderWidth = 1
        yearButton.layer.borderColor = UIColor.lightGray.cgColor
        yearButton.semanticContentAttribute = .forceRightToLeft
        yearButton.addTarget(self, action: #selector(toggleYearPicker), for: .touchUpInside)
        return yearButton
    }()
    
    private let listFilmsTable: UITableView = {
        let listFilmsTable = UITableView()
        listFilmsTable.backgroundColor = .black
        return listFilmsTable
    }()
    
    private lazy var exitButton: UIBarButtonItem = {
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?
            .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        return UIBarButtonItem(image: image,
                               style: .plain,
                               target: self,
                               action: #selector(tappedExit))
    }()
    
    private lazy var sortedButton: UIButton = {
        let sortedButton = UIButton()
        let image = UIImage(systemName: "arrow.up.arrow.down")
        sortedButton.setImage(image, for: .normal)
        sortedButton.addAction(
            UIAction { [weak self] _ in
                self?.tapSortedButton()
            },
            for: .touchUpInside
        )
        return sortedButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupDelegate()
        setupUI()
        createListFilmsTable()
        presenter?.setupDataSource()
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
        view.addSubview(yearButton)
        view.addSubview(listFilmsTable)
        view.addSubview(sortedButton)
        navigationItem.hidesBackButton = true
        
        let topInset: CGFloat = 125
        let elementHeight: CGFloat = 44
        let horizontalPadding: CGFloat = 16
        
        sortedButton.frame = CGRect(
            x: horizontalPadding,
            y: topInset,
            width: elementHeight,
            height: elementHeight
        )
        
        searchTextFild.frame = CGRect(
            x: sortedButton.frame.maxX + horizontalPadding,
            y: topInset,
            width: view.bounds.width - sortedButton.frame.maxX - horizontalPadding - horizontalPadding,
            height: elementHeight
        )
        
        yearButton.frame = CGRect(
            x: horizontalPadding,
            y: topInset + elementHeight + 8,
            width: view.bounds.width - 2 * horizontalPadding,
            height: elementHeight
        )
        
        listFilmsTable.frame = CGRect(
            x: 0,
            y: yearButton.frame.maxY + 8,
            width: view.bounds.width,
            height: view.bounds.height - yearButton.frame.maxY - view.safeAreaInsets.bottom
        )
    }
    
    // MARK: - Actions
    @objc
    private func tappedExit() {
        view.endEditing(true)
        presenter?.performLogaut()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func tapSortedButton() {
        sortedButton.showsMenuAsPrimaryAction = true
        
        let sortedDefault = UIAction(title: "Сортировка по умолчанию",
                                     state: currentSorted == .sortedDefault ? .on : .off,
                                     handler: { [weak self] _ in
            self?.currentSorted = .sortedDefault
            self?.tapSortedButton()
        })
        
        let sortedDescending = UIAction(title: "Сортировка по убыванию",
                                        state: currentSorted == .sortedDescending ? .on : .off,
                                        handler: { [weak self] _ in
            self?.currentSorted = .sortedDescending
            self?.tapSortedButton()
        })
        
        let sortedAscending = UIAction(title: "Сортировка по возрастанию",
                                       state: currentSorted == .sortedAscending ? .on : .off,
                                       handler: { [weak self] _ in
            self?.currentSorted = .sortedAscending
            self?.tapSortedButton()
        })
        sortedButton.menu = UIMenu(title: "", children: [sortedDefault, sortedDescending, sortedAscending])
    }
    
    @objc
    private func toggleYearPicker() {
        var years: [GenericPickerViewController.YearFilter] = [.allYears]
        var array = Array(1990...2025).map({ GenericPickerViewController.YearFilter.specificYear($0) })
        years.append(contentsOf: array)
        
        let pickerVC = GenericPickerViewController.makePickerController(with: years)
          if let navVC = pickerVC as? UINavigationController,
             let yearPickerVC = navVC.topViewController as? GenericPickerViewController {
              yearPickerVC.delegate = self
          }
        present(pickerVC, animated: true)
    }
    
    private func setupDelegate() {
        searchTextFild.delegate = self
    }
    
    private func createListFilmsTable() {
        listFilmsTable.register(CustomCell.self, forCellReuseIdentifier: CustomCell.filmCellIdentifier)
        listFilmsTable.dataSource = self
        listFilmsTable.delegate = self
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension FilmsListViewController: FilmsListView {
    
    func didLoadFilms(films: [FilmsListItem]) {
        self.films = films
        listFilmsTable.reloadData()
    }
}

// MARK: UITableViewDelegate & DataSourse
extension FilmsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.filmCellIdentifier,
                                                       for: indexPath) as? CustomCell,
              indexPath.row < films.count
              else {
            return UITableViewCell()
        }
        let film = films[indexPath.row]
        cell.configure(with: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let film = films[indexPath.row]
        
        let detailFilmsVC = FilmDetailsViewController()
        // let presenterFilmsVC = presenter?.makeFilmsDetailPresenter(film: film)
        
//        detailFilmsVC.presenter = presenterFilmsVC
//        presenterFilmsVC?.view = detailFilmsVC
        
        // navigationController?.pushViewController(detailFilmsVC, animated: true)
    }
}

// MARK: UITextFieldDelegate
extension FilmsListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextFild {
            searchTextFild.resignFirstResponder()
        }
        return true
    }
}

extension FilmsListViewController: CustomPickerDelegate {
    
    func didSelectYear(year: GenericPickerViewController.YearFilter) {
        yearButton.setTitle(year.stringValue, for: .normal)
    }
}
