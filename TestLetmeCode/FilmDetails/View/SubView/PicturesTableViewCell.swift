//
//  PicturesTableViewCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 18.04.2025.
//

import UIKit

class PicturesTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    static let identifier = "picturesCell"
    private let cache = NSCache<NSString, UIImage>()
    private var imageURLs: [URL] = []
    
    private let picturesLabel: UILabel = {
        let picturesLabel = UILabel()
        picturesLabel.text = "Кадры"
        picturesLabel.font = .systemFont(ofSize: 22, weight: .bold)
        picturesLabel.textColor = .white
        picturesLabel.translatesAutoresizingMaskIntoConstraints = false
        return picturesLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 80)
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PicturesCollectionCell.self, forCellWithReuseIdentifier: PicturesCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        contentView.addSubview(picturesLabel)
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            picturesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            picturesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            collectionView.topAnchor.constraint(equalTo: picturesLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure(with urls: [URL]) {
        imageURLs = urls
        collectionView.reloadData()
    }
}

extension PicturesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionCell.identifier, for: indexPath) as! PicturesCollectionCell
        
        let imageUrl = imageURLs[indexPath.item]
        cell.configure(with: imageUrl)

        return cell
    }
}
