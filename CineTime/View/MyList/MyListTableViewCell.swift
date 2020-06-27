//
//  MyListTableViewCell.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 10/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class MyListTableViewCell: UITableViewCell {
    
    static let identifier = "myCell"
    
    var film: Film? {
        didSet {
            self.imageFilm.downloaded(from: "https://image.tmdb.org/t/p/w500/\(film?.poster_path ?? "nil")")
            self.title.text = film?.title
            self.category.text = "\(film?.genre_ids ?? [12])"
        }
    }
    
    lazy var imageFilm: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = label.font.withSize(17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(11)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aventura, Ação, Fantasia"
        return label
    }()
    
    lazy var advisoryRating: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "l.square")
        return imageView
    }()
    
    override func prepareForReuse() {
        self.imageFilm.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(imageFilm)
        addSubview(title)
        addSubview(category)
        addSubview(advisoryRating)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageFilm.heightAnchor.constraint(equalToConstant: 106),
            imageFilm.widthAnchor.constraint(equalToConstant: 76),
            imageFilm.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageFilm.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            imageFilm.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)

        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.imageFilm.trailingAnchor, constant: 6),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -46),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            category.leadingAnchor.constraint(equalTo: self.imageFilm.trailingAnchor, constant: 6),
            category.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            advisoryRating.leadingAnchor.constraint(equalTo: self.imageFilm.trailingAnchor, constant: 6),
            advisoryRating.topAnchor.constraint(equalTo: self.category.bottomAnchor, constant: 6),
            advisoryRating.heightAnchor.constraint(equalToConstant: 14.38),
            advisoryRating.widthAnchor.constraint(equalToConstant: 14.38)
        ])
    }
    
}
