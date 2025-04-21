//
//  FilmDetailsViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    var presenter: FilmDetailsPresenter?
    
    private var cellTypes: [FilmDetailCellType] = []
    
    private let imageFilms: UIImageView = {
        let imageFilms = UIImageView()
        
        return imageFilms
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .cyan
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
        presenter?.setupDataSourse()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let horizontalPadding: CGFloat = 16
        let safeAreaTop: CGFloat = 100
        let imageHeight = view.bounds.height / 2.5
        
        imageFilms.frame = CGRect(
            x: 0,
            y: safeAreaTop,
            width: view.bounds.width,
            height: imageHeight
        )
        
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: view.bounds.width * 0.6 - horizontalPadding, height: UIView.layoutFittingExpandedSize.height))
        titleLabel.frame = CGRect(
            x: horizontalPadding,
            y: imageFilms.frame.maxY - titleLabelSize.height - horizontalPadding,
            width: titleLabelSize.width,
            height: titleLabelSize.height
        )
        
        let ratingLabelSize = ratingLabel.sizeThatFits(CGSize(width: view.bounds.width * 0.2, height: 30))
        ratingLabel.frame = CGRect(
            x: view.bounds.width - horizontalPadding - ratingLabelSize.width,
            y: imageFilms.frame.maxY - horizontalPadding - ratingLabelSize.height,
            width: ratingLabelSize.width,
            height: ratingLabelSize.height
        )
        
        movieDiscription.frame = CGRect(
            x: 0,
            y: imageFilms.frame.maxY + horizontalPadding / 2,
            width: view.bounds.width,
            height: view.bounds.height - imageFilms.frame.maxY - view.safeAreaInsets.bottom
        )
    }
    
    private func setupUI() {
        view.addSubview(imageFilms)
        view.addSubview(titleLabel)
        view.addSubview(ratingLabel)
        view.addSubview(movieDiscription)
    }
    
    private func configureMovieDiscriptionTable() {
        movieDiscription.dataSource = self
        movieDiscription.delegate = self
        movieDiscription.register(DetailsFilmTableViewCell.self, forCellReuseIdentifier: DetailsFilmTableViewCell.cellidentidire)
        movieDiscription.register(GenreYearTableViewCell.self, forCellReuseIdentifier: GenreYearTableViewCell.cellidentidire)
        movieDiscription.register(PicturesTableViewCell.self, forCellReuseIdentifier: PicturesTableViewCell.identifier)
        movieDiscription.separatorStyle = .none
    }
}

extension FilmDetailsViewController: FilmDetailsView {
    
    func showFilmDetails(title: String, rating: Decimal, cellTypes: [FilmDetailCellType], imageUrl: URL?) {
        titleLabel.text = title
        ratingLabel.text = "\(rating)"
        self.cellTypes = cellTypes
        imageFilms.image = UIImage(systemName: "play.rectangle.fill")
        
        if let imageUrl = imageUrl {
            NetworkImpl.downloadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageFilms.image = image ?? UIImage(systemName: "play.rectangle.fill")
                }
            }
        }
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
            
        case .movieHeaderPicture(_):
            return UITableViewCell()
            
        case .description(let link, let description):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsFilmTableViewCell.cellidentidire,
                                                           for: indexPath) as? DetailsFilmTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(discription: description, link: link)
            return cell
            
        case .genreAndYear(let genre, let startYear, let endYear, let country):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreYearTableViewCell.cellidentidire,
                                                           for: indexPath) as? GenreYearTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(genres: genre, countries: country, startYear: startYear, endYear: endYear)
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
