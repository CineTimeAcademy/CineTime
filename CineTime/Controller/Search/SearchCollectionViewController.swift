//
//  SearchCollectionViewController.swift
//  CineTime
//
//  Created by Brena Amorim on 16/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // UICollectionViewDelegateFlowLayout é um protocolo que define o tamanho dos itens e o espaçamento entre eles no grid
    let cellId = "titleCell"
    let listOfTitles = [Title(image: "1"), Title(image: "2"), Title(image: "3"), Title(image: "4"), Title(image: "5"), Title(image: "6"), Title(image: "7"), Title(image: "8"), Title(image: "9"), Title(image: "10"), Title(image: "11"), Title(image: "12"), Title(image: "13"), Title(image: "14"), Title(image: "15"), Title(image: "16"), Title(image: "17"), Title(image: "1"), Title(image: "2"), Title(image: "3")]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
        configureNavBar()
        collectionView.register(TitlesCollectionCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func configureNavBar() {
        // Place the search bar in the navigation item's title view.
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.set(textColor: .white)
        searchController.searchBar.setTextField(color: .actionColor)
        searchController.searchBar.setPlaceholder(textColor: .white)
        searchController.searchBar.setSearchImage(color: .white)
        searchController.searchBar.setClearButton(color: .white)
       // searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.isActive = true

        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .systemYellow
        }
        
        //collectionView.addSubview(searchController.searchBar)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfTitles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TitlesCollectionCell
        cell.title = listOfTitles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 151)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    print(searchController.searchBar.text)
  }
}
