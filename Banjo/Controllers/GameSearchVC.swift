//
//  GameSearchVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - GameSearchVCDelegate

protocol GameSearchVCDelegate: class {
    func gameSearchVCDidTapDismiss(gameSearchVC: GameSearchVC)
    func gameSearchVCDidSelectGame(gameSearchVC: GameSearchVC, game: GamePartial)
}

// MARK: - GameSearchVC: UIViewController, NibLoadable

class GameSearchVC: UIViewController, NibLoadable {
    
    // MARK: Properties
    
    var delegate: GameSearchVCDelegate?
    var dataSource: GameSearchDS! = nil
    
    // MARK: Outlets
    
    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var gamesSearchBar: UISearchBar!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Search"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-arrow"), style: .plain, target: self, action: #selector(back))
        
        gamesTableView.delegate = self
        gamesTableView.dataSource = dataSource
        gamesTableView.separatorColor = .clear
        gamesTableView.registerCellWithNib(GameCell.self, bundle: Bundle.main)
        gamesTableView.registerCellWithNib(EmptyCell.self, bundle: Bundle.main)
        dataSource.delegate = self
        dataSource.state = .empty
        gamesSearchBar.delegate = self
        gamesSearchBar.autocapitalizationType = .none
        gamesSearchBar.placeholder = "Search query..."
        gamesSearchBar.accessibilityIdentifier = "searchBar"        
    }
    
    // MARK: Actions
    
    @objc func back() {
        delegate?.gameSearchVCDidTapDismiss(gameSearchVC: self)
    }
}

// MARK: - GameSearchVC: UISearchBarDelegate

extension GameSearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // if query is empty, then we are done
        if searchText == "" {
            dataSource.games = []
            dataSource.state = .empty
            gamesTableView?.reloadData()
            return
        }
        
        // if the search is still running, then cancel all the operations on the queue
        dataSource.cancelSearch()
        
        // start new search
        dataSource.fetchList(forQuery: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - GameSearchVC: GameSearchDSDelegate

extension GameSearchVC: GameSearchDSDelegate {
    func gameSearchDataSourceDidFetchGames(gameSearchDataSource: GameSearchDS) {
        gamesTableView.reloadData()
    }
    
    func gameSearchDataSource(_ gameSearchDataSource: GameSearchDS, didFailWithError error: Error) {
        displayAlert(title: "Error", message: error.localizedDescription, dismissHandler: nil)
    }
}

// MARK: - GameSearchVC: UIGestureRecognizerDelegate

extension GameSearchVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return gamesSearchBar.isFirstResponder
    }
}

// MARK: - GameSearchVC: UITableViewDelegate

extension GameSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource.state {
        case .empty:
            return 45.0
        default:
            return 65.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = dataSource.games[indexPath.row]        
        delegate?.gameSearchVCDidSelectGame(gameSearchVC: self, game: game)
    }
}
