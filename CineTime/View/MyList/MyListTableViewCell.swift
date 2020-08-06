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
    
    let sectionsHeader : [String: String] = [
        "28":"Ação",
        "12":"Aventura",
        "16":"Animação",
        "35":"Comédia",
        "80":"Crime",
        "99":"Documentário",
        "18":"Drama",
        "14":"Fantasia",
        "27":"Horror",
        "10402":"Musical",
        "9648":"Mistério",
        "10749":"Romance",
        "878":"Ficção cientifica",
        "53":"Suspense", "10770":"Séries",
        "10752":"Guerra",
        "37":"Faroeste"
    ]
    
    var film: Movie? {
        didSet {
            self.imageFilm.downloaded(from: "https://image.tmdb.org/t/p/w500/\(film?.poster_path ?? "nil")")
            self.title.text = film?.title
            self.category.text = formatCategories(film: film!)
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
    
    public func formatCategories(film: Movie) -> String {
        var categories = [String]()

        guard let categoriesId = film.genre_ids else {
            return "Não existe categorias cadastradas."
        }
        for id in categoriesId {
            categories.append(sectionsHeader[String(id)] ?? "")
        }
        let result = categories.compactMap { $0 }
        
        return result.joined(separator: ", ") + "."
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
