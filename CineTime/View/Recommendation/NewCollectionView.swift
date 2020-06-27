//
//  NewCollectionView.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class NewCollectionView: UICollectionView, UICollectionViewDelegate {
    
    var moviesAPI = [Film]()
    weak var delegatePush: DelegatePushDescriptionViewController?


    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        getNewMovies()
        
        self.dataSource = self
        self.delegate = self
        
        self.decelerationRate = .fast // uncomment if necessary
        self.contentInsetAdjustmentBehavior = .always
        self.register(NewsPosterCell.self, forCellWithReuseIdentifier: "NewsCell")
        self.isPagingEnabled = false
        self.showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getNewMovies() {
        Service.shared.nowPlaying() { films in
            films?.forEach({ film in
                self.moviesAPI.append(film)
            })
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
}

extension NewCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesAPI.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsPosterCell
        cell.film = moviesAPI[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegatePush?.didSelect(movie: moviesAPI[indexPath.item])
    }
}
