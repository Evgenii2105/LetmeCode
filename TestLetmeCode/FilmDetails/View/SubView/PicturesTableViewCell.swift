//
//  PicturesTableViewCell.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 18.04.2025.
//

import UIKit

class PicturesTableViewCell: UITableViewCell {
    
    static let cellidentidire = "picturesCell"
    static let cellidentifireCollection = "picturesCollection"
    
    private var imageNames: [String] = []
    
    private let picturesLabel: UILabel = {
        let picturesLabel = UILabel()
        picturesLabel.text = "Кадры"
        picturesLabel.font = .systemFont(ofSize: 22, weight: .bold)
        picturesLabel.textColor = .white
        picturesLabel.numberOfLines = 1
        picturesLabel.translatesAutoresizingMaskIntoConstraints = false
        return picturesLabel
    }()
    
    private let picturesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 80)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let picturesCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        picturesCollection.backgroundColor = .blue
        picturesCollection.translatesAutoresizingMaskIntoConstraints = false
        return picturesCollection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupContraints()
        setupDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDelegate() {
        picturesCollection.register(UICollectionViewCell.self,
                                    forCellWithReuseIdentifier: PicturesTableViewCell.cellidentifireCollection)
        picturesCollection.delegate = self
        picturesCollection.dataSource = self
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(picturesLabel)
        contentView.addSubview(picturesCollection)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            
            picturesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            picturesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            picturesLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            picturesCollection.topAnchor.constraint(equalTo: picturesLabel.bottomAnchor, constant: 8),
            picturesCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            picturesCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            picturesCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            picturesCollection.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configure(with imageNames: [String]) {
        self.imageNames = imageNames
        picturesCollection.reloadData()
    }
}

extension PicturesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesTableViewCell.cellidentifireCollection, for: indexPath)
        
        cell.contentView.subviews.forEach({ $0.removeFromSuperview() })
        
        let imageView = UIImageView(frame: cell.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: imageNames[indexPath.item]) 
        cell.contentView.addSubview(imageView)
        return cell
    }
}
