//
//  SearchCollectionViewController.swift
//  CineTime
//
//  Created by Brena Amorim on 16/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "titleCell"
    let searchController = UISearchController(searchResultsController: nil)
    var arrayOfResults = [String]()
    var resultsOfSearch = 0
    var emptyState : Bool = false
    var listOfResults = [Film]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.navigationItem.title = "\(self.listOfResults.count) resultados"
                if (self.listOfResults.count == 0) {
                    self.showEmptyState()
                } else {
                    self.hideEmptyState()
                }
            }
        }
    }
    
    lazy var emptyStateMessage: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "Nenhum resgistro encontrado"
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()
        return messageLabel
    }()
    
    lazy var imageInitial: UIImageView = {
        let imagem = UIImageView()
        imagem.image = UIImage(named: "initialSearch")
        imagem.translatesAutoresizingMaskIntoConstraints = false
        return imagem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        configureNavBar()
        collectionView.register(TitlesCollectionCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func configureNavBar() {
        // Place the search bar in the navigation item's title view.
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .actionColor
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.set(textColor: .white)
        searchController.searchBar.setTextField(color: .actionColor)
        searchController.searchBar.setPlaceholder(textColor: .white)
        searchController.searchBar.setSearchImage(color: .white)
        searchController.searchBar.setClearButton(color: .white)
        searchController.searchResultsUpdater = self
        searchController.isActive = true
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .systemYellow
        }
    }
    
    func showEmptyState() {
        emptyState = true
        collectionView.addSubview(emptyStateMessage)
        NSLayoutConstraint.activate([
            emptyStateMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showInitialImage () {
        collectionView.addSubview(imageInitial)
        NSLayoutConstraint.activate([
            imageInitial.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageInitial.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func hideEmptyState() {
        if emptyState {
            emptyStateMessage.removeFromSuperview()
        }
        emptyState = true
    }
    
    func hideInitialImage () {
        imageInitial.removeFromSuperview()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.listOfResults.count == 0 && emptyState == false {
            showInitialImage()
        } else {
            hideInitialImage()
        }
        return self.listOfResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TitlesCollectionCell
        
        let urlPoster = "https://image.tmdb.org/t/p/w500" + listOfResults[indexPath.row].poster_path!
        cell.imageTitle.downloaded(from: urlPoster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 151)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = listOfResults[indexPath.item]
        let destination = DescriptionViewController()
        destination.dataFilm = movie
        navigationController?.pushViewController(destination, animated: true)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        var textSearchBar = searchController.searchBar.text!
        textSearchBar = textSearchBar.replacingOccurrences(of: " ", with: "%20")
        listOfResults = [Film]()
        Service.shared.searchByName(name: textSearchBar) { films in
            films?.forEach({ film in
                if (film.poster_path != nil && film.overview != nil) {
                    self.listOfResults.append(film)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchController.dismiss(animated: true, completion: nil)
        return true
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
