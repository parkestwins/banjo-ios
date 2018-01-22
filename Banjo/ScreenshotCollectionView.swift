//
//  ScreenshotCollectionView.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// - ScreenshotCollectionView: UICollectionView

class ScreenshotCollectionView: UICollectionView {
    
    // MARK: UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alwaysBounceHorizontal = true
        backgroundColor = UIColor.clear
        registerCellWithNib(ScreenshotCell.self, bundle: Bundle.main)
    }
}
