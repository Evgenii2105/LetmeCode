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
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Описание"
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let linkButton: UIButton = {
        let linkButton = UIButton()
        let image = UIImage(systemName: "link")
        linkButton.setImage(image, for: .normal)
        return linkButton
    }()
    
    private let movieDescription: UILabel = {
        let movieDescription = UILabel()
        movieDescription.textColor = .white
        movieDescription.text = "Классный фильм"
        return movieDescription
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(linkButton)
        contentView.addSubview(movieDescription)
        
        titleLabel.frame = CGRect(
            x: 16,
            y: 8,
            width: contentView.bounds.height / 2,
            height: 28
        )
        
        linkButton.frame = CGRect(
            x: titleLabel.frame.maxX + 16,
            y: 8,
            width: 22,
            height: 22
        )
        
        movieDescription.frame = CGRect(
            x: 16,
            y: titleLabel.frame.maxY + 16,
            width: 60,
            height: contentView.frame.height - titleLabel.frame.maxY
        )
    }
    
    func configure(description: String, link: URL?) {
        movieDescription.text = description
        linkButton.isHidden = link == nil
    }
}
