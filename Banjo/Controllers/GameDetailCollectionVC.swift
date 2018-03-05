//
//  GameDetailCollectionVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - GameDetailCollectionVC: BaseCollectionVC

class GameDetailCollectionVC: BaseCollectionVC {
    
    // MARK: Properties
    
    var gameID: Int?
        
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gameDetailDataSource = GameDetailDS()        
        if let gameID = gameID {
            gameDetailDataSource.gameID = gameID            
        }
        dataSource = gameDetailDataSource
        
        refreshData(refreshControl)
    }

    // MARK: Setup
    
    override func setupCollectionView() {
        collectionView?.dataSource = dataSource
        collectionView?.registerCellWithNib(GameDetailCell.self, bundle: Bundle.main)
        collectionView?.registerSupplementaryViewWithNib(GameDetailHeaderCell.self, forKind: UICollectionElementKindSectionHeader, bundle: Bundle.main)
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
    }
    
    override func setupNavigation() {
        navigationItem.title = "Game Detail"
    }
    
    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch dataSource.state {
        case .empty, .error:
            return CGSize.zero
        default:
            switch section {
            case 0:
                return CGSize(
                    width: UIScreen.main.bounds.size.width,
                    height: UIScreen.main.bounds.size.height * 0.3
                )
            default:
                return CGSize.zero
            }
        }
    }
}
