//
//  BaseCollectionDataSource.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit
import Foundation

// MARK: - DataSourceState

enum DataSourceState {
    case ready
    case empty
    case normal
    case loading
    case error
}

// MARK: - BaseCollectionDataSource: NSObject, UICollectionViewDataSource

class BaseCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: Properties
    
    let queue = OperationQueue()
    var state: DataSourceState = .ready
    var error: Error?
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch state {
        case .error, .empty:
            return 1
        default:
            return dataSourceNumberOfSections(in: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 0
        case .error, .empty:
            return 1
        default:
            return dataSourceCollectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .error:
            let cell: ErrorCollectionCell = collectionView.dequeueReusableCellFromNib(forIndexPath: indexPath)
            return cell
        case .empty:
            return dataSourceCollectionView(collectionView, emptyCellForItemAt: indexPath)
        default:
            return dataSourceCollectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch state {
        case .normal:
            return dataSourceCollectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        default:
            let view: EmptySupplementaryCell = collectionView.dequeueReusableSupplementaryViewFromNib(ofKind: kind, forIndexPath: indexPath)
            return view
        }
    }
    
    // MARK: Default Behaviors
    
    func dataSourceCollectionView(_ collectionView: UICollectionView, emptyCellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func dataSourceNumberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func dataSourceCollectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func dataSourceCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func dataSourceCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    // MARK: Load Data from Network
    
    func reload(completion: @escaping (AnyObject?) -> (), error: @escaping (Error?) -> ()) {}
}

