//
//  RowTableViewCollectionViewCell.swift
//  CineTime
//
//  Created by Beatriz Carlos on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class RowTableViewCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView : UIImageView = {
        var imageView =  UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageViewConstraints() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
