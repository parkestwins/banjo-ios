//
//  UIImageView+Cache.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func imageFromCache(_ urlString: String) {
        if let url = URL(string: urlString) {
            kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(1))],
                        progressBlock: nil, completionHandler: nil)
        }
    }
}
