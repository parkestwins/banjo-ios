//
//  GenreCell.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
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
        maxWidthConstraint.constant = UIScreen.main.bounds.width - 32
    }
}
