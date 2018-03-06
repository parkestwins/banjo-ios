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
        let platformVC = PlatformVC(style: .plain)
        platformVC.delegate = self
        navigationController.viewControllers = [platformVC]
    }
    
    func showGameSearchVCWithPlatform(_ platform: Platform) {
        let gameSearchVC = GameSearchVC.loadFromNib(bundle: Bundle.main)
        gameSearchVC.delegate = self
        gameSearchVC.dataSource = GameSearchDS(platform: platform)
        navigationController.pushViewController(gameSearchVC, animated: true)
    }
}

// MARK: - ContentFC: PlatformVCDelegate

extension ContentFC: PlatformVCDelegate {
    func platformVCDidTapDismiss(platformVC: PlatformVC) {
        delegate?.contentFCDidTapDismiss(contentFC: self)
    }
    
    func platformVCDidSelectPlatform(platformVC: PlatformVC, platform: Platform) {
        showGameSearchVCWithPlatform(platform)
    }
}

// MARK: - ContentFC: GameSearchVCDelegate

extension ContentFC: GameSearchVCDelegate {
    func gameSearchVCDidTapDismiss(gameSearchVC: GameSearchVC) {
        navigationController.popViewController(animated: true)
    }
    
    func gameSearchVCDidSelectGame(gameSearchVC: GameSearchVC, game: GamePartial) {
        let gameDetailVC = GameDetailVC(collectionViewLayout: UICollectionViewFlowLayout.oneColumnStretchLayout())
        gameDetailVC.gameID = game.id
        navigationController.pushViewController(gameDetailVC, animated: true)
    }
}
