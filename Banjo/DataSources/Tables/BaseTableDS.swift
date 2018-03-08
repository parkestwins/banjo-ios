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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceNumberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 0
        case .error, .empty:
            return 1
        default:
            return dataSourceNumberOfRowsInSection(in: tableView, section: section)
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
    
    func dataSourceNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func dataSourceNumberOfRowsInSection(in tableView: UITableView, section: Int) -> Int {
        return 1
    }
    
    func dataSourceTableView(_ tableView: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func dataSourceTableView(_ tableView: UITableView, emptyCellForItemAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

