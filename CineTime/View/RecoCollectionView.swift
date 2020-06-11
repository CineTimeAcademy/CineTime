//
//  RecoCollectionView.swift
//  CineTime
//
//  Created by Leonardo Gomes on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class RecoCollectionView: UICollectionView, UICollectionViewDelegate {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        
        self.decelerationRate = .fast // uncomment if necessary
        self.contentInsetAdjustmentBehavior = .always
        self.register(MoviePosterCell.self, forCellWithReuseIdentifier: "CELL")
        self.isPagingEnabled = false
        self.showsHorizontalScrollIndicator = false
//        self.contentOffset.x =  layout.itemSize.width + layout.minimumLineSpacing

        
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

extension RecoCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! MoviePosterCell
        return cell
    }
    
}
