//
//  NewsPosterCell.swift
//  CineTime
//
//  Created by Leonardo Gomes on 15/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class NewsPosterCell: UICollectionViewCell {
    
    var film: Film? {
        didSet {
            guard let unwrappedFilm = film else { return }


            let name = unwrappedFilm.poster_path

            let api = FilmsAPI(route: .getImageFilm(name: name))

            guard let url = api.url else { return }

            posterImageView.downloaded(from: url.absoluteString)
            
        }
    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        setupPoster()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPoster() {
        self.addSubview(posterImageView)
  
        posterImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        posterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.88).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
}
