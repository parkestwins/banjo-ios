//
//  UITableView+RegisterNibs.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - UITableView (Register Nibs)

extension UITableView {
    
    func registerCellWithNib<T: UITableViewCell>(_: T.Type, bundle: Bundle) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCellFromNib<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("could not dequeue cell with identifier: \(className)")
        }
        
        return cell
    }
}
