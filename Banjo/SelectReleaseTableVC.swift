//
//  SelectReleaseTableVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/7/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import UIKit

class SelectReleaseTableVC: UITableViewController {
    
    // MARK: Properties
    
    var game: Game?
    var selectedRelease: Release?
    let reuseIdentifier = "releaseCell"
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        setupUI()
    }
    
    // MARK: Setup
    
    func setupUI() {
        title = "Select Release"
        let gameCellNib = UINib(nibName: "ReleaseCell", bundle: nil)
        tableView.register(gameCellNib, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - SelectReleaseTableVC (UITableViewDataSource)

extension SelectReleaseTableVC {
    
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
            if let releaseRegionAbbv = release.region?.abbreviation {
                releaseCell.regionReleaseLabel.text = "\(releaseRegionAbbv) / \(release.date.toString())"
            } else {
                releaseCell.regionReleaseLabel.text = "\(release.date.toString())"
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

// MARK: - SelectReleaseTableVC (UITableViewDelegate)

extension SelectReleaseTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let game = game {
            selectedRelease = game.releases[indexPath.row]
            tableView.reloadData()
            performSegue(withIdentifier: "saveRelease", sender: self)
        }
    }
}
