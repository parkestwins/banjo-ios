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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func searchViewController(controller: RealmSearchVC, cellForObject object: Object, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath as IndexPath)
        if let game = object as? Game {
            cell.textLabel?.text = game.title
        }
        return cell
    }        
}
