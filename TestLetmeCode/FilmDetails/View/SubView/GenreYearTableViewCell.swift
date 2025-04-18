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
        genreLabel.textColor = .white
        genreLabel.text = "Genre Label"
        genreLabel.numberOfLines = 1
        return genreLabel
    }()
    
    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.textColor = .white
        yearLabel.text = "Year"
        yearLabel.numberOfLines = 1
        return yearLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(genreLabel)
        contentView.addSubview(yearLabel)
        
        genreLabel.frame = CGRect(
            x: 16,
            y: 8,
            width: contentView.bounds.width / 3,
            height: 24
        )
        
        yearLabel.frame = CGRect(
            x: 16,
            y: genreLabel.frame.maxY + 8,
            width: contentView.bounds.width,
            height: contentView.frame.height - 24 - 8
        )
    }
    
    func configure(genre: String, year: Decimal) {
        genreLabel.text = genre
        yearLabel.text = "\(year)"
    }
    
}
