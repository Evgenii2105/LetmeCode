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
        picturesLabel.textColor = .white
        picturesLabel.numberOfLines = 1
        return picturesLabel
    }()
    
    private let picturesImage: UIImageView = {
        let picturesImage = UIImageView()
        picturesImage.image = .actions
        return picturesImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(picturesLabel)
        contentView.addSubview(picturesImage)
        
        picturesLabel.frame = CGRect(
            x: 16,
            y: 8,
            width: contentView.bounds.width / 3,
            height: 28
        )
        
        picturesImage.frame = CGRect(
            x: 16,
            y: picturesLabel.frame.maxY + 8,
            width: contentView.bounds.width,
            height: contentView.frame.height - 28 - 8
        )
    }
    
    func configure(with imageNames: [String]) {
        
    }
}
