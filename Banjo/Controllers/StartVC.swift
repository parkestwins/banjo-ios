//
//  StartVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - StartVC: UIViewController, NibLoadable

class StartVC: UIViewController, NibLoadable {
    
    // MARK: Outlets
    
    @IBOutlet weak var searchGamesButton: UIButton!
    @IBOutlet weak var searchImageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchImageView.tintColor = .white
        searchImageView.alpha = 0.70
        searchGamesButton.accessibilityIdentifier = "searchButton"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)        
    }
    
    // MARK: Actions
    
    @IBAction func searchTapped(_ sender: Any) {
        let gameSearchVC = GameSearchVC.loadFromNib(bundle: Bundle.main)
        navigationController?.pushViewController(gameSearchVC, animated: true)
    }
}
