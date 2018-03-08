//
//  PlatformVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 3/5/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - PlatformVCDelegate

protocol PlatformVCDelegate: class {
    func platformVCDidTapDismiss(platformVC: PlatformVC)
    func platformVCDidSelectPlatform(platformVC: PlatformVC, platform: Platform)
}

// MARK: - PlatformVC: UITableViewController

class PlatformVC: UITableViewController {
    
    // MARK: Properties
    
    var delegate: PlatformVCDelegate?
    var dataSource = PlatformDS()
    
    // MARK: Outlets
    
    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var gamesSearchBar: UISearchBar!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Pick Console"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-arrow"), style: .plain, target: self, action: #selector(back))
        
        dataSource.state = .normal
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        
        tableView.separatorColor = .clear
        tableView.registerCellWithNib(PlatformCell.self, bundle: Bundle.main)
        tableView.registerCellWithNib(EmptyCell.self, bundle: Bundle.main)
    }
    
    // MARK: Actions
    
    @objc func back() {
        delegate?.platformVCDidTapDismiss(platformVC: self)
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let platform = dataSource.platforms[indexPath.section][indexPath.row]
        delegate?.platformVCDidSelectPlatform(platformVC: self, platform: platform)
    }
}
