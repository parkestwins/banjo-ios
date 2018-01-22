//
//  ScreenshotCell.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - ScreenshotCell: BaseCollectionCell

class ScreenshotCell: BaseCollectionCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
}
