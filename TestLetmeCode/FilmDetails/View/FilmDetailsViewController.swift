//
//  FilmDetailsViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    var presenter: FilmDetailsPresenter?
    
    private var cellTypes: [Film.FildDetailCellType] = []
    
    private let imageFilms: UIImageView = {
        let imageFilms = UIImageView()
        imageFilms.image = UIImage(systemName: "play.rectangle.fill")
        return imageFilms
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = "Во все тяжкие"
        return titleLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .white
        ratingLabel.text = "9.8"
        return ratingLabel
    }()
    
    private let movieDiscription: UITableView = {
        let movieDiscription = UITableView()
        movieDiscription.backgroundColor = .black
        return movieDiscription
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        configureMovieDiscriptionTable()
        
    }
    
    private func setupUI() {
        view.addSubview(imageFilms)
        view.addSubview(titleLabel)
        view.addSubview(ratingLabel)
        view.addSubview(movieDiscription)
        
        let horizontalPadding: CGFloat = 16
        let safeAreaTop: CGFloat = 90
        let imageHeight = view.bounds.height / 2.5
        
        imageFilms.frame = CGRect(
            x: 0,
            y: safeAreaTop,
            width: view.bounds.width,
            height: imageHeight
        )
        
        titleLabel.frame = CGRect(
            x: horizontalPadding,
            y: imageFilms.frame.maxY - 60,
            width: view.bounds.width * 0.6 - horizontalPadding,
            height: 30
        )
        
        ratingLabel.frame = CGRect(
            x: titleLabel.frame.maxX + 3 * horizontalPadding,
            y: imageFilms.frame.maxY - 60,
            width: view.bounds.width * 0.4 - horizontalPadding,
            height: 30
        )
        
        movieDiscription.frame = CGRect(
            x: 0,
            y: imageFilms.frame.maxY,
            width: view.bounds.width,
            height: view.bounds.height - imageFilms.frame.maxY - view.safeAreaInsets.bottom
        )
    }
    
    private func configureMovieDiscriptionTable() {
        movieDiscription.dataSource = self
        movieDiscription.delegate = self
        movieDiscription.register(DetailsFilmTableViewCell.self, forCellReuseIdentifier: DetailsFilmTableViewCell.cellidentidire)
        movieDiscription.register(GenreYearTableViewCell.self, forCellReuseIdentifier: GenreYearTableViewCell.cellidentidire)
        movieDiscription.register(PicturesTableViewCell.self, forCellReuseIdentifier: PicturesTableViewCell.cellidentidire)
        movieDiscription.separatorStyle = .none
    }
}

extension FilmDetailsViewController: FilmDetailsView {
    
    func showFilmDetails(film: Film) {
        titleLabel.text = film.title
        ratingLabel.text = "\(film.rating)"
        cellTypes = film.toCellTypes()
        movieDiscription.reloadData()
    }
}

extension FilmDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = cellTypes[indexPath.row]
        
        switch cellType {
            
        case .description(let text, let link):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsFilmTableViewCell.cellidentidire,
                                                           for: indexPath) as? DetailsFilmTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(description: text, link: link)
            return cell
            
        case .genreAndYear(let genre, let year):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreYearTableViewCell.cellidentidire,
                                                           for: indexPath) as? GenreYearTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(genre: genre, year: year)
            return cell
            
        case .pictures(let imageNames):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PicturesTableViewCell.cellidentidire,
                                                           for: indexPath) as? PicturesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: imageNames)
            return cell
        }
    }
}
