//
//  PicturesCollection.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 21.04.2025.
//

import UIKit

class PicturesCollectionCell: UICollectionViewCell {
    
    static let identifier = "PicturesCollectionCell"
    private static let cache = NSCache<NSURL, UIImage>()
    private var imageUrl: URL?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrl: URL) {
        
        self.imageUrl = imageUrl
        
        if let image = Self.cache.object(forKey: imageUrl as NSURL) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo")?.withTintColor(.lightGray)
            NetworkImpl.downloadImage(from: imageUrl) { [weak self] image in
                guard let self = self else { return }
                
                if let image = image {
                    Self.cache.setObject(image, forKey: imageUrl as NSURL)
                    DispatchQueue.main.async {
                        if imageUrl == self.imageUrl {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
    }
}
