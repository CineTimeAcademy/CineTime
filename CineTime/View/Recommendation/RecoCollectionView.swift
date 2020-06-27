//
//  RecoCollectionView.swift
//  CineTime
//
//  Created by Leonardo Gomes on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class RecoCollectionView: UICollectionView, UICollectionViewDelegate {
    
    let flowLayout = ZoomAndSnapFlowLayout()
    var context = CIContext(options: nil)
    let image =  UIImageView()
    weak var delegatePush: DelegatePushDescriptionViewController?
    
    var moviesAPI = [Film]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        getRecoMovies()
        
        self.dataSource = self
        self.delegate = self
        self.reloadData()
        
        self.decelerationRate = .fast // uncomment if necessary
        self.contentInsetAdjustmentBehavior = .always
        self.register(MoviePosterCell.self, forCellWithReuseIdentifier: "RecoCell")
        self.isPagingEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.contentOffset.x = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        
//        let image1 = UIImageView()
//        self.backgroundView = image1
//        image1.image = UIImage(named: movies[1].posterName)
//        image1.alpha = 0.3
//        image1.contentMode = .scaleAspectFill
//        blurEffect(bg: image1, context: context)
        
//        let image =  UIImageView()
//        DispatchQueue.main.async {
//            let film = self.moviesAPI[1]
//            let path = film.poster_path
//            let api = FilmsAPI(route: .getImageFilm(name: path))
//
//            guard let url = api.url else { return }
//            image.downloadedBlur(from: url)
//            image.alpha = 0.3
//            image.contentMode = .scaleAspectFill
//            self.backgroundView = image
//            self.contentOffset.x = self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing
//        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRecoMovies() {
        Service.shared.getRecomendations(filmId: "479455") { films in
            
            for i in 0...2 {
                self.moviesAPI.append(films![i])
            }
//            films?.forEach({ film in
//
//                self.moviesAPI.append(film)
//            })
            DispatchQueue.main.async {
                let film = self.moviesAPI[1]
                let path = film.poster_path
                let api = FilmsAPI(route: .getImageFilm(name: path!))

                guard let url = api.url else { return }
                self.image.downloadedBlur(from: url)
                self.image.alpha = 0.3
                self.image.contentMode = .scaleAspectFill
                self.backgroundView = self.image
                self.contentOffset.x = self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing
                self.reloadData()
            }
        }
    }
}

extension RecoCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if moviesAPI.count < 3 {
//            return moviesAPI.count
//        }
        return moviesAPI.count
//        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecoCell", for: indexPath) as! MoviePosterCell
        cell.film = moviesAPI[indexPath.item]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y)
        let indexPath = indexPathForItem(at: center)
        let image =  UIImageView()
        
        
        if let index = indexPath?.item {
            let film = moviesAPI[index]
            let path = film.poster_path
            let api = FilmsAPI(route: .getImageFilm(name: path!))

            guard let url = api.url else { return }
            image.downloadedBlur(from: url)
        }
        
        image.alpha = 0.3
        image.contentMode = .scaleAspectFill
        self.backgroundView = image
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegatePush?.didSelect(movie: moviesAPI[indexPath.item])
    }
}
