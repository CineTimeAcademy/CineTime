//
//  NewCollectionView.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class NewCollectionView: UICollectionView, UICollectionViewDelegate {
    
    private let movies: [Movie] = [Movie(posterName: "1"), Movie(posterName: "2"), Movie(posterName: "3"), Movie(posterName: "4"), Movie(posterName: "5"), Movie(posterName: "6"), Movie(posterName: "7"), Movie(posterName: "8"), Movie(posterName: "9"), Movie(posterName: "10")]
    
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
//        self.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
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

//extension RecoCollectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
//}


extension NewCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesAPI.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsPosterCell
//        cell.movie = movies[indexPath.item]
        cell.film = moviesAPI[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegatePush?.didSelect(movie: moviesAPI[indexPath.item])
    }
}
