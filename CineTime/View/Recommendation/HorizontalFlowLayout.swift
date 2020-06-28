//
//  HorizontalFlowLayout.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class HorizontalFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 8
        itemSize = CGSize(width: 90, height: 163)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 3

        sectionInset = UIEdgeInsets(top: verticalInsets + 26, left: 16, bottom: verticalInsets, right: 0)

        super.prepare()
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}
