//
//  RealmSearchTableVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - RealmSearchTableVC: RealmSearchViewController

class RealmSearchTableVC: RealmSearchVC {
    
    private let reuseIdentifier = "gameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Setup
    
    func setupUI() {
        title = "N64 Games"
        let gameCellNib = UINib(nibName: "GameCell", bundle: nil)
        tableView.register(gameCellNib, forCellReuseIdentifier: reuseIdentifier)
    }

    override func searchViewController(controller: RealmSearchVC, cellForObject object: Object, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        if let game = object as? Game, let gameCell = cell as? GameCell {
            gameCell.titleLabel.text = game.title
            if let releaseDate = game.releases.first?.date {
                gameCell.releaseLabel.text = DateHelper.dateToString(releaseDate)
            }            
        }
        return cell
    }
    
    override func searchViewController(controller: RealmSearchVC, didSelectObject anObject: Object, atIndexPath indexPath: NSIndexPath) {
        if let game = anObject as? Game {
            performSegue(withIdentifier: "showDetail", sender: game)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let game = sender as? Game, let gameDetailVC = segue.destination as? GameDetailVC, segue.identifier == "showDetail" {
            gameDetailVC.game = game
        }
    }
}
