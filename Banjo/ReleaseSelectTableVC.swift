//
//  ReleaseSelectTableVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/7/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - ReleaseSelectTableVC: UITableViewController

class ReleaseSelectTableVC: UITableViewController {
    
    // MARK: Properties
    
    var game: Game?
    var selectedRelease: Release?
    let reuseIdentifier = AppConstants.IDs.releaseCell
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: RealmConstants.updateNotification), object: nil, queue: nil) { notification in
            self.tableView.reloadData()
        }
        setupUI()
    }
    
    // MARK: Deinitializer
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Setup
    
    private func setupUI() {
        title = AppConstants.Strings.selectReleaseTitle
        let gameCellNib = UINib(nibName: AppConstants.Nibs.releaseCell, bundle: nil)
        tableView.register(gameCellNib, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - ReleaseSelectTableVC (UITableViewDataSource)

extension ReleaseSelectTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let releases = game?.releases {
            return releases.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        if let game = game, let releaseCell = cell as? ReleaseCell {
            let release = game.releases[indexPath.row]
            releaseCell.titleLabel.text = release.specialTitle ?? game.title
            
            if let releaseRegionAbbv = release.region?.abbreviation, let date = release.date {
                releaseCell.regionReleaseLabel.text = "\(releaseRegionAbbv) / \(date.toString())"
            } else if let date = release.date {
                releaseCell.regionReleaseLabel.text = "\(date.toString())"
            }
            
            if let selectedRelease = selectedRelease, release.id == selectedRelease.id {
                releaseCell.regionSelectImage.isHighlighted = true
            } else {
                releaseCell.regionSelectImage.isHighlighted = false
            }            
        }
        return cell
    }
}

// MARK: - ReleaseSelectTableVC (UITableViewDelegate)

extension ReleaseSelectTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let game = game {
            selectedRelease = game.releases[indexPath.row]
            tableView.reloadData()
            performSegue(withIdentifier: AppConstants.Segues.saveRelease, sender: self)
        }
    }
}
