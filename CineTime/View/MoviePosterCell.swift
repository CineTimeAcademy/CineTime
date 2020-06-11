//
//  MoviePosterCell.swift
//  CineTime
//
//  Created by Leonardo Gomes on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class MoviePosterCell: UICollectionViewCell {
//
//    private let posterImageView: UIImageView = {
//        let imageView = UIImageView(image: )
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 200)
//        return imageView
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
