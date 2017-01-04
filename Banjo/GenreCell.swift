//
//  GenreCell.swift
//
//  Created by Diep Nguyen Hoang on 7/30/15.
//  Copyright © 2015 CodenTrick. All rights reserved.
//  github.com/luceefer/TagFlowExample
//
//  Modified by Jarrod Parkes on 12/23/16.
//

import UIKit

// MARK: - GenreCell: UICollectionViewCell

class GenreCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var maxWidthConstraint: NSLayoutConstraint!
    
    // MARK: NSObject 
    
    override func awakeFromNib() {
        layer.cornerRadius = 4
        maxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2
    }
}
