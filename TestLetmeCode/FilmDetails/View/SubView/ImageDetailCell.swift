//
//  ImageDetailCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 27.04.2025.
//

import UIKit

class ImageDetailCell: UITableViewCell {
    
    static let cellidentidire = "imageDetailCell"
    
    private let imageFilms: UIImageView = {
        let imageFilms = UIImageView()
        imageFilms.contentMode = .scaleAspectFill
        imageFilms.clipsToBounds = true
        imageFilms.translatesAutoresizingMaskIntoConstraints = false
        return imageFilms
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .cyan
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        contentView.addSubview(imageFilms)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageFilms.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageFilms.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageFilms.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageFilms.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageFilms.heightAnchor.constraint(equalToConstant: 470),
            
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7),
            
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40),
            ratingLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configure(name: String?, imageUrl: URL?, rating: Decimal) {
        ratingLabel.text = "\(rating)"
        titleLabel.text = name
        
        if let imageUrl = imageUrl {
            NetworkImpl.downloadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageFilms.image = image ?? UIImage(systemName: "play.rectangle.fill")
                }
            }
        }
    }
}
