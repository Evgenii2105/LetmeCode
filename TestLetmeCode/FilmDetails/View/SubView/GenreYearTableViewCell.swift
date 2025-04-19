//
//  GenreYearTableViewCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 18.04.2025.
//

import UIKit

class GenreYearTableViewCell: UITableViewCell {
    
    static let cellidentidire = "genreYearCell"
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.textColor = .lightGray
        genreLabel.numberOfLines = 1
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreLabel
    }()
    
    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.textColor = .lightGray
        yearLabel.numberOfLines = 1
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        return yearLabel
    }()
    
    private let countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.numberOfLines = 1
        countryLabel.textColor = .lightGray
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(genreLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(countryLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            genreLabel.heightAnchor.constraint(equalToConstant: 28),
            
            yearLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            yearLabel.trailingAnchor.constraint(lessThanOrEqualTo: countryLabel.leadingAnchor, constant: -8),
            
            countryLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 8),
            countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            countryLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(genre: String, year: Decimal, country: String) {
        genreLabel.text = genre
        yearLabel.text = "\(year) •"
        countryLabel.text = country
    }
}
