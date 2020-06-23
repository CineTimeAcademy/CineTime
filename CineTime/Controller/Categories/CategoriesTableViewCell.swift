//
//  CategoriesTableViewCell.swift
//  teste
//
//  Created by Beatriz Carlos on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

protocol DelegatePushDescriptionViewController: NSObjectProtocol {
    func didSelectItem()
}

class CategoriesTableViewCell: UITableViewCell {
    weak var delegate: DelegatePushDescriptionViewController?
    
    var collectionView : UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        callAPI()
        print(listOfResultsByGenre.count)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var listOfResultsByGenre = [Film]()
    func callAPI() {
        Service.shared.findFilmByGenre(with: ["12"], completion: { films in
            films?.forEach({ film in
                self.listOfResultsByGenre.append(film)
            })
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    func setLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        
        return layout
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
        collectionView.backgroundColor = .black
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.register(RowTableViewCollectionViewCell.self, forCellWithReuseIdentifier: "MyCellCollection")
        addSubview(collectionView)
        setDelegatesCollectionView()
        setupConstraint()
    }
    
    func setDelegatesCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupConstraint() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

extension CategoriesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfResultsByGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellCollection", for: indexPath) as! RowTableViewCollectionViewCell
           
        let urlPoster = "https://image.tmdb.org/t/p/w500" + listOfResultsByGenre[indexPath.row].poster_path!
           cell.imageView.downloaded(from: urlPoster)
           return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 111, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem()
    }
}
