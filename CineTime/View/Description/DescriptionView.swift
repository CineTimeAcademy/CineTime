//
//  Description.swift
//  CineTime
//
//  Created by Beatriz Carlos on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

enum DisplayNameApi: String {
    case netflix = "Netflix"
    case amazonPrime = "Amazon Prime Video"
    case amazonInstant = "Amazon Instant Video"
    case telecine = "Telecine"
    case disney = "Disney+"
    case appleTv = "Apple TV Plus"
}


class DescriptionView: UIView {
    // Collection header names.
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
    
    var streaming: Streaming = Streaming(name: "") {
        didSet {
            switch streaming.display_name! {
            case DisplayNameApi.netflix.rawValue:
                DispatchQueue.main.async {
                    self.stackStreamings.addArrangedSubview(self.netflixImage)
                }
            case DisplayNameApi.amazonPrime.rawValue, DisplayNameApi.amazonInstant.rawValue:
                DispatchQueue.main.async {
                    self.stackStreamings.addArrangedSubview(self.amazonImage)
                }
            case DisplayNameApi.disney.rawValue:
                DispatchQueue.main.async {
                    self.stackStreamings.addArrangedSubview(self.disneyImage)
                }
            case DisplayNameApi.appleTv.rawValue:
                DispatchQueue.main.async {
                    self.stackStreamings.addArrangedSubview(self.appleTvImage)
                }
            case DisplayNameApi.telecine.rawValue:
                DispatchQueue.main.async {
                    self.stackStreamings.addArrangedSubview(self.telecineImage)
                }
            default:
                print("nada")
            }
        }
    }
    
    init(frame: CGRect, data: Movie) {
        super.init(frame: frame)
        result(film: data)
        addSubviews()
        configureView()
        autoLayout()
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
    
    func result(film: Movie) {
        switch film.media_type {
        case "movie":
            titleLabel.text = film.title
        case "tv":
            titleLabel.text = film.name
        default:
            titleLabel.text = film.title
        }
        descriptionTextView.text = film.overview
        captionLabel.text = formatDate(data: film.release_date!)
        imdbLabel.text = String(format:"%.1f", film.vote_average!)
        categoriesLabel.text = formatCategories(film: film)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    lazy var titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        label.textAlignment = .left
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var myListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "buttonMinhaListaDisable"), for: .normal)
        button.setImage(UIImage(named: "buttonMinhaLista"), for: .selected)
        return button
    }()
    
    lazy var categoriesLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageImdb : UIImageView = {
        let imagem = UIImageView()
        imagem.image = UIImage(named: "imdb")
        imagem.translatesAutoresizingMaskIntoConstraints = false
        return imagem
    }()
    
    lazy var imdbLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.textAlignment = .left
        label.text = "8.4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextView : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .none
        label.numberOfLines = 100
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = ""
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var captionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        label.textAlignment = .left
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var disponibleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textAlignment = .left
        label.text = "Disponível em:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var stackStreamings : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.contentMode = .left
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var amazonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: "amazon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var netflixImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: "netflix")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var appleTvImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: "appletv")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var disneyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: "disney")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var telecineImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: "telecine")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(myListButton)
        addSubview(categoriesLabel)
        addSubview(imageImdb)
        addSubview(imdbLabel)
        addSubview(descriptionTextView)
        addSubview(captionLabel)
        addSubview(disponibleLabel)
        addSubview(stackStreamings)
        
       
//        stackStreamings.addArrangedSubview(amazonImage)
//        stackStreamings.addArrangedSubview(appleTvImage)
//        stackStreamings.addArrangedSubview(telecineImage)
//        stackStreamings.addArrangedSubview(disneyImage)
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
    }
    
    func formatDate(data: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatterGet.date(from: data) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return ""
    }
    
    func autoLayout() {
        // Title
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
        
        // buton minha lista
        NSLayoutConstraint.activate([
            myListButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            myListButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
        
        // Categories
        NSLayoutConstraint.activate([
            categoriesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            categoriesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
        
        // Image IMDB
        NSLayoutConstraint.activate([
            imageImdb.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageImdb.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 5),
            imageImdb.heightAnchor.constraint(equalToConstant: 38.4),
            imageImdb.widthAnchor.constraint(equalToConstant: 38.4)
        ])
        
        // Label IMDB
        NSLayoutConstraint.activate([
            imdbLabel.leadingAnchor.constraint(equalTo: imageImdb.leadingAnchor, constant: 45),
            imdbLabel.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 16)
        ])
        
        // Description
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionTextView.topAnchor.constraint(equalTo: imageImdb.bottomAnchor, constant: 10)
        ])
        
        // Caption label.
        NSLayoutConstraint.activate([
            captionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            captionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            captionLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20)
        ])
        
        // Disponible label.
        NSLayoutConstraint.activate([
            disponibleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            disponibleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            disponibleLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10),
//            disponibleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // stack view
        
        NSLayoutConstraint.activate([
            
            stackStreamings.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackStreamings.topAnchor.constraint(equalTo: disponibleLabel.bottomAnchor, constant: 10),
            stackStreamings.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
        
    }
}
