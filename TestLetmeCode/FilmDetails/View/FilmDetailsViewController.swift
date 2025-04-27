//
//  FilmDetailsViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: FilmDetailsPresenter?
    private var cellTypes: [FilmDetailCellType] = []
    
    // MARK: - UI Components
    private let filmDetailsTable: UITableView = {
        let filmDetailsTable = UITableView()
        filmDetailsTable.backgroundColor = .black
        return filmDetailsTable
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        configureMovieDiscriptionTable()
        presenter?.setupDataSourse()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filmDetailsTable.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filmDetailsTable.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    private func setupUI() {
        view.addSubview(filmDetailsTable)
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configureMovieDiscriptionTable() {
        filmDetailsTable.dataSource = self
        filmDetailsTable.delegate = self
        filmDetailsTable.register(ImageDetailCell.self, forCellReuseIdentifier: ImageDetailCell.cellidentidire)
        filmDetailsTable.register(DetailsFilmTableViewCell.self, forCellReuseIdentifier: DetailsFilmTableViewCell.cellidentidire)
        filmDetailsTable.register(GenreYearTableViewCell.self, forCellReuseIdentifier: GenreYearTableViewCell.cellidentidire)
        filmDetailsTable.register(PicturesTableViewCell.self, forCellReuseIdentifier: PicturesTableViewCell.identifier)
        filmDetailsTable.separatorStyle = .none
    }
}

extension FilmDetailsViewController: FilmDetailsView {
    
    func showFilmDetails(cellTypes: [FilmDetailCellType]) {
        self.cellTypes = cellTypes
        filmDetailsTable.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSourse
extension FilmDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = cellTypes[indexPath.row]
        
        switch cellType {
            
        case .movieHeaderPicture(let imageURl, let name, let rating):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.cellidentidire, for: indexPath) as? ImageDetailCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.configure(name: name, imageUrl: imageURl, rating: rating)
            return cell
            
        case .description(let link, let description):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsFilmTableViewCell.cellidentidire,
                                                           for: indexPath) as? DetailsFilmTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(discription: description, link: link)
            return cell
            
        case .genreAndYear(let genre, let startYear, let endYear, let country, let year):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreYearTableViewCell.cellidentidire,
                                                           for: indexPath) as? GenreYearTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(genres: genre, countries: country, startYear: startYear, endYear: endYear, year: year)
            return cell
            
        case .pictures(let imageUrls):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PicturesTableViewCell.identifier,
                                                           for: indexPath) as? PicturesTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: imageUrls)
            return cell
        }
    }
}
