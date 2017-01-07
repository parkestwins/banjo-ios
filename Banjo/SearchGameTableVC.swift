//
//  SearchGameTableVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - SearchGameTableVC: RealmSearchViewController

class SearchGameTableVC: RealmSearchVC {
    
    // MARK: Properties
    
    private let reuseIdentifier = "gameCell"
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        setupUI()
    }
    
    // MARK: Setup
    
    func setupUI() {
        title = "N64 Games"
        let gameCellNib = UINib(nibName: "GameCell", bundle: nil)
        tableView.register(gameCellNib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Actions
    
    @IBAction func toStartScreen(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }

    // MARK: RealmSearchResultsDataSource
    
    override func searchViewController(controller: RealmSearchVC, cellForObject object: Object, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        if let game = object as? Game, let gameCell = cell as? GameCell {
            gameCell.titleLabel.text = game.title
            if let firstRelease = game.releases.first, let region = firstRelease.region, let date = firstRelease.date {
                gameCell.regionReleaseLabel.text = "\(region.abbreviation) / \(date.toString())"
            } else {
                gameCell.regionReleaseLabel.text = "Unreleased"
            }
        }
        return cell
    }
    
    // MARK: RealmSearchResultsDelegate
    
    override func searchViewController(controller: RealmSearchVC, didSelectObject anObject: Object, atIndexPath indexPath: IndexPath) {
        if let game = anObject as? Game {
            performSegue(withIdentifier: "showDetail", sender: game)
        }
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let game = sender as? Game, let gameDetailVC = segue.destination as? GameDetailVC, segue.identifier == "showDetail" {
            gameDetailVC.game = game
                        
            if let usRegion = realm.objects(Region.self).filter("abbreviation = 'US'").first {
                let sortedReleases = game.releases.sorted(byProperty: "date")
                let usReleases = game.releases.filter("region == %@", usRegion).sorted(byProperty: "date")
                
                if usReleases.count > 0 {
                    gameDetailVC.selectedRelease = usReleases.first
                } else {
                    gameDetailVC.selectedRelease = sortedReleases.first
                }
            } else {
                gameDetailVC.selectedRelease = game.releases.first
            }
        }
    }
}
