//
//  ContentFC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 3/5/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ContentFCDelegate

protocol ContentFCDelegate: class {
    func contentFCDidTapDismiss(contentFC: ContentFC)
}

// MARK: - ContentFC: RootViewFC

class ContentFC: RootViewFC {
    
    // MARK: Properties
    
    let services: Services
    var childFCs: [FlowCoordinator] = []
    var rootViewController: UIViewController { return navigationController }
    var delegate: ContentFCDelegate?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    // MARK: Initializer
    
    init(withServices services: Services) {
        self.services = services
    }
    
    // MARK: FlowCoordinator
    
    func start() {
        let gameSearchVC = GameSearchVC.loadFromNib(bundle: Bundle.main)
        gameSearchVC.delegate = self
        gameSearchVC.dataSource = GameSearchDS(platform: .n64)
        navigationController.viewControllers = [gameSearchVC]
    }
}

// MARK: - ContentFC: GameSearchVCDelegate

extension ContentFC: GameSearchVCDelegate {
    func gameSearchVCDidTapDismiss(gameSearchVC: GameSearchVC) {
        delegate?.contentFCDidTapDismiss(contentFC: self)
    }
    
    func gameSearchVCDidSelectGame(gameSearchVC: GameSearchVC, game: GamePartial) {
        let gameDetailVC = GameDetailVC(collectionViewLayout: UICollectionViewFlowLayout.oneColumnStretchLayout())
        gameDetailVC.gameID = game.id
        navigationController.pushViewController(gameDetailVC, animated: true)
    }
}
