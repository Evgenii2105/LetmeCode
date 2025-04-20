//
//  CustomCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let filmCellIdentifier = "customCellFilm"
    
    private let filmImageView: UIImageView = {
        let filmImageView = UIImageView()
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.clipsToBounds = true
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        return filmImageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.textColor = .lightGray
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreLabel
    }()
    
    private let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.font = .systemFont(ofSize: 14, weight: .bold)
        detailsLabel.textColor = .lightGray
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailsLabel
    }()
    
    private let raitingLabel: UILabel = {
        let raitingLabel = UILabel()
        raitingLabel.font = .systemFont(ofSize: 16, weight: .bold)
        raitingLabel.textColor = .systemBlue
        raitingLabel.translatesAutoresizingMaskIntoConstraints = false
        return raitingLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(filmImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(raitingLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            filmImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            filmImageView.widthAnchor.constraint(equalToConstant: 80),
            filmImageView.heightAnchor.constraint(equalToConstant: 120),
            
            raitingLabel.bottomAnchor.constraint(equalTo: filmImageView.bottomAnchor),
            raitingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            raitingLabel.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: filmImageView.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            detailsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            detailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with film: FilmsListItem) {
        filmImageView.image = UIImage(systemName: "film")?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = film.name
        genreLabel.text = film.genres.map({ $0.genre }).joined(separator: ",")
        let countries = film.countries.map { $0.country }.joined(separator: ",")
        detailsLabel.text = "\(film.year) • \(countries)"
        raitingLabel.text = "★ \(film.ratingKinopoisk)"
    }
}
