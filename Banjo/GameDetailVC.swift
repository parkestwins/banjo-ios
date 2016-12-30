//
//  GameDetailVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import Firebase

// MARK: - GameDetailVC: UIViewController

class GameDetailVC: UIViewController {
    
    // MARK: Properties
    
    var game: Game?
    
    // MARK: Outlets
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var playersImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
        
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = game {
            titleLabel.text = game.title
            // FIXME: pick release based on user region. fallback: pick first release by date?
            if let release = game.releases.first {                
                releaseDateLabel.text = DateHelper.dateToString(release.date)
                developerLabel.text = release.developer
                publisherLabel.text = release.publisher
                ratingLabel.text = release.rating?.abbreviation
                summaryLabel.text = release.summary
                let coverImagePath = release.coverImagePath
                if release.coverImagePath.hasPrefix("gs://") {
                    FIRStorage.storage().reference(forURL: coverImagePath).data(withMaxSize: INT64_MAX){ (data, error) in
                        if let error = error {
                            print("Error downloading: \(error)")
                            return
                        }
                        DispatchQueue.main.async {
                            self.coverImageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
        }
    }
}
