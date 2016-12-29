//
//  GameDetailVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

class GameDetailVC: UIViewController {
    
    var game: Game?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var playersImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = game {
            titleLabel.text = game.title
            publisherLabel.text = game.publisher
        }
    }
}
