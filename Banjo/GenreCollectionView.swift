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
        alwaysBounceHorizontal = true
        backgroundColor = UIColor.clear
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        registerCellWithNib(GenreCell.self, bundle: Bundle.main)
    }
}
