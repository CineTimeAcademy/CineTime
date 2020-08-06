//
//  MoviePosterCell.swift
//  CineTime
//
//  Created by Leonardo Gomes on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class MoviePosterCell: UICollectionViewCell {

    var film: Movie? {
        didSet {
            guard let unwrappedFilm = film else { return }
            let name = unwrappedFilm.poster_path
            let api = FilmsAPI(route: .getImageFilm(name: name!))

            guard let url = api.url else { return }
            posterImageView.downloaded(from: url.absoluteString)
            
        }
    }
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear        
        setupPoster()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPoster() {
        self.addSubview(posterImageView)
        
        posterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
}
