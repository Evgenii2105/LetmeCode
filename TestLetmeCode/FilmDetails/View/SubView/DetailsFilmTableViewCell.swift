//
//  DetailsFilmTableViewCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 18.04.2025.
//

import UIKit

class DetailsFilmTableViewCell: UITableViewCell {
    
    static let cellidentidire = "detailFilmCell"
    
    weak var delegate: TapLinkDelegate?
    private var link: URL?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Описание"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var linkButton: UIButton = {
        let linkButton = UIButton()
        let image = UIImage(systemName: "link")
        linkButton.setImage(image, for: .normal)
        linkButton.tintColor = .cyan
        linkButton.addTarget(self, action: #selector(tappedLinkBuitton), for: .touchUpInside)
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        return linkButton
    }()
    
    private let movieDescription: UILabel = {
        let movieDescription = UILabel()
        movieDescription.numberOfLines = 0
        movieDescription.textColor = .white
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        return movieDescription
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(linkButton)
        contentView.addSubview(movieDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: linkButton.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            linkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            linkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            linkButton.widthAnchor.constraint(equalToConstant: 22),
            linkButton.heightAnchor.constraint(equalToConstant: 22),
            
            movieDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            movieDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure( discription: String?, link: URL?) {
        movieDescription.text = discription
        self.link = link
    }
    
    @objc
    private func tappedLinkBuitton() {
        guard let link = link else { return }
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }
}
