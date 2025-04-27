//
//  FilmsListViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class FilmsListViewController: UIViewController {
    
    enum FilmSorting {
        case sortedDefault
        case sortedDescending
        case sortedAscending
    }
    
    // MARK: - Properties
    var presenter: FilmsListPresenter?
    private var currentSorted: FilmSorting = .sortedDefault
    private var films: [FilmsListItem] = []
    
    // MARK: - UI Components
    private lazy var searchTextFild: UITextField = {
        let searchTextFild = UITextField()
        searchTextFild.attributedPlaceholder = NSAttributedString(
            string: "Поиск фильмов",
            attributes: [.foregroundColor: UIColor.lightGray])
        
        searchTextFild.borderStyle = .roundedRect
        searchTextFild.layer.borderWidth = 1
        searchTextFild.layer.borderColor = UIColor.lightGray.cgColor
        searchTextFild.layer.cornerRadius = 8
        searchTextFild.backgroundColor = .black
        searchTextFild.textColor = .white
        
        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.tintColor = .cyan
        searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        searchButton.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        buttonContainer.addSubview(searchButton)
        
        searchTextFild.rightView = buttonContainer
        searchTextFild.rightViewMode = .always
        
        return searchTextFild
    }()
    
    private lazy var yearButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Фильмы по годам"
        config.image = UIImage(systemName: "chevron.down")?
            .withTintColor(.cyan, renderingMode: .alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.baseForegroundColor = .white
        
        let yearButton = UIButton(configuration: config)
        yearButton.backgroundColor = .black
        yearButton.layer.borderWidth = 1
        yearButton.layer.cornerRadius = 8
        yearButton.layer.borderColor = UIColor.lightGray.cgColor
        yearButton.addTarget(self, action: #selector(toggleYearPicker), for: .touchUpInside)
        
        return yearButton
    }()
    
    private let listFilmsTable: UITableView = {
        let listFilmsTable = UITableView()
        listFilmsTable.backgroundColor = .black
        return listFilmsTable
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var exitButton: UIBarButtonItem = {
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?
            .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        let exitButton = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(tappedExit)
        )
        exitButton.tintColor = .cyan
        return exitButton
    }()
    
    private lazy var sortedButton: UIButton = {
        let sortedButton = UIButton()
        let image = UIImage(systemName: "arrow.up.arrow.down")
        sortedButton.setTitleColor(.cyan, for: .normal)
        sortedButton.tintColor = .cyan
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
        listFilmsTable.refreshControl = refreshControl
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let top = view.safeAreaInsets.top + 16
        let elementHeight: CGFloat = 44
        let horizontalPadding: CGFloat = 16
        
        sortedButton.frame = CGRect(
            x: horizontalPadding,
            y: top,
            width: elementHeight,
            height: elementHeight
        )
        
        searchTextFild.frame = CGRect(
            x: sortedButton.frame.maxX + horizontalPadding,
            y: top,
            width: view.bounds.width - sortedButton.frame.maxX - horizontalPadding - horizontalPadding,
            height: elementHeight
        )
        
        yearButton.frame = CGRect(
            x: horizontalPadding,
            y: top + elementHeight + 8,
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
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Кинопоиск"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .cyan
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
    }
    
    // MARK: - Actions
    @objc
    private func tappedExit() {
        view.endEditing(true)
        presenter?.performLogaut()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pullToRefresh() {
        refreshControl.beginRefreshing()
        currentSorted = .sortedDefault
        presenter?.setupDataSource()
        refreshControl.endRefreshing()
    }
    
    @objc
    private func tappedSearchButton() {
        presenter?.search(with: searchTextFild.text)
    }
    
    @objc
    private func tapSortedButton() {
        sortedButton.showsMenuAsPrimaryAction = true
        
        let sortedDefault = UIAction(title: "Сортировка по умолчанию",
                                     state: currentSorted == .sortedDefault ? .on : .off,
                                     handler: { [weak self] _ in
            self?.currentSorted = .sortedDefault
            self?.tapSortedButton()
            self?.presenter?.sort(by: .sortedDefault)
        })
        
        let sortedDescending = UIAction(title: "Сортировка по убыванию рейтинга",
                                        state: currentSorted == .sortedDescending ? .on : .off,
                                        handler: { [weak self] _ in
            self?.currentSorted = .sortedDescending
            self?.tapSortedButton()
            self?.presenter?.sort(by: .sortedDescending)
        })
        
        let sortedAscending = UIAction(title: "Сортировка по возрастанию рейтинга",
                                       state: currentSorted == .sortedAscending ? .on : .off,
                                       handler: { [weak self] _ in
            self?.currentSorted = .sortedAscending
            self?.tapSortedButton()
            self?.presenter?.sort(by: .sortedAscending)
        })
        sortedButton.menu = UIMenu(title: "", children: [sortedDefault, sortedDescending, sortedAscending])
    }
    
    @objc
    private func toggleYearPicker() {
        var years: [GenericPickerViewController.YearFilter] = [.allYears]
        let array = Array(1990...2025).map({ GenericPickerViewController.YearFilter.specificYear($0) })
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
        listFilmsTable.register(FilmDataCell.self, forCellReuseIdentifier: FilmDataCell.filmCellIdentifier)
        listFilmsTable.dataSource = self
        listFilmsTable.delegate = self
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension FilmsListViewController: FilmsListView {
    
    func didConfigureDetailsPresenter(detailsPresenter: FilmDetailsPresenterImpl) {
        let detailsVC = FilmDetailsViewController()
        detailsPresenter.view = detailsVC
        detailsVC.presenter = detailsPresenter
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmDataCell.filmCellIdentifier,
                                                       for: indexPath) as? FilmDataCell,
              indexPath.row < films.count
        else {
            return UITableViewCell()
        }
        
        let film = films[indexPath.row]
        cell.configure(with: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.makeFilmsDetailPresenter(film: films[indexPath.row])
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
        presenter?.filter(by: year)
    }
}
