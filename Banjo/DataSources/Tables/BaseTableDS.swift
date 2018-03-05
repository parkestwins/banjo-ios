//
//  BaseTableDS.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit
import Foundation

// MARK: - BaseTableDS: NSObject, UITableViewDataSource

class BaseTableDS: NSObject, UITableViewDataSource {
    
    // MARK: Properties
    
    var state: DataSourceState = .ready
    var error: Error?
    
    // MARK: UICollectionViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 0
        case .error, .empty:
            return 1
        default:
            return dataSourceNumberOfRowsInSection(in: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .error:
            return dataSourceTableView(tableView, cellForItemAt: indexPath)
        case .empty:
            return dataSourceTableView(tableView, emptyCellForItemAt: indexPath)
        default:
            return dataSourceTableView(tableView, cellForItemAt: indexPath)
        }
    }
    
    // MARK: Default Behaviors
    
    func dataSourceNumberOfRowsInSection(in tableView: UITableView) -> Int {
        return 1
    }
    
    func dataSourceTableView(_ tableView: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func dataSourceTableView(_ tableView: UITableView, emptyCellForItemAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

