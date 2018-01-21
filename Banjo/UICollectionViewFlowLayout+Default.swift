//
//  UICollectionViewFlowLayout+Default.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    static func oneColumnStretchLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        
        // make cells "self-sizing" (engineering.shopspring.com/dynamic-cell-sizing-in-uicollectionview-fd95f614ef80)
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        
        return flowLayout
    }
    
    static func defaultLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.size.width,
            height: 1000
        )
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 8, 0)
        return flowLayout
    }
}

