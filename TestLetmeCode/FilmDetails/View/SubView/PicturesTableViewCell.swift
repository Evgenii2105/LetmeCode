//
//  PicturesTableViewCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 18.04.2025.
//

import UIKit

class PicturesTableViewCell: UITableViewCell {
    
    static let cellidentidire = "picturesCell"
    
    private let picturesLabel: UILabel = {
        let picturesLabel = UILabel()
        picturesLabel.text = "Кадры"
        picturesLabel.font = .systemFont(ofSize: 22, weight: .bold)
        picturesLabel.textColor = .white
        picturesLabel.numberOfLines = 1
        picturesLabel.translatesAutoresizingMaskIntoConstraints = false
        return picturesLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(picturesLabel)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            
            picturesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            picturesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            picturesLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            picturesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with imageNames: [String]) {
        
    }
}
