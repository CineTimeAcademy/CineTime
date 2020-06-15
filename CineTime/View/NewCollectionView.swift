//
//  NewCollectionView.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class NewCollectionView: UICollectionView, UICollectionViewDelegate {
    
    private let movies: [Movie] = [Movie(posterName: "freira"), Movie(posterName: "dolemite"), Movie(posterName: "aniquilacao"), Movie(posterName: "midsomar"), Movie(posterName: "murder"), Movie(posterName: "no_limite"), Movie(posterName: "nos"), Movie(posterName: "quarto"), Movie(posterName: "se_beber"), Movie(posterName: "teoria_de_tudo")]
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        
        
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
}

//extension RecoCollectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
//}

extension NewCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsPosterCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
}
