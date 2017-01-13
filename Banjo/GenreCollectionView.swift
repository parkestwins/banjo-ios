//
//  GenreCollectionView.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// - GenreCollectionView: UICollectionView

class GenreCollectionView: UICollectionView {
    
    // MARK: Properties
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    // MARK: UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
}
