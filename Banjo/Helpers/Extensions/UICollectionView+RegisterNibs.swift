//
//  UICollectionView+RegisterNibs.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - UICollectionView (Register Nibs)

extension UICollectionView {
    
    func registerCellWithNib<T: UICollectionViewCell>(_: T.Type, bundle: Bundle) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func registerSupplementaryViewWithNib<T: UICollectionViewCell>(_: T.Type, forKind kind: String, bundle: Bundle) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func dequeueReusableCellFromNib<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("could not dequeue cell with identifier: \(className)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryViewFromNib<T: UICollectionViewCell>(ofKind kind: String, forIndexPath indexPath: IndexPath) -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("could not dequeue supplementary view with identifier: \(className)")
        }
        
        return view
    }
}
