//
//  UIViewController+NibLoadable.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var nibNameIdentifier: String { get }
}

extension NibLoadable where Self: UIViewController {
    static var nibNameIdentifier: String {
        return String(describing: self)
    }
    
    static func loadFromNib(bundle: Bundle) -> Self {
        return Self(nibName: Self.nibNameIdentifier, bundle: bundle)
    }
}
