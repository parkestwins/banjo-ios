//
//  AppFC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - AppFC: RootViewFC

public class AppFC: RootViewFC {
    
    // MARK: Properties
    
    public let services: Services
    public var childFCs: [FlowCoordinator] = []
    public var rootViewController: UIViewController { return navigationController }
  
    private let window: UIWindow
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    // MARK: Initializer
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    // MARK: FlowCoordinator
    
    public func start() {
        let startVC = StartVC.loadFromNib(bundle: Bundle.main)
        startVC.delegate = self
        navigationController.viewControllers = [startVC]
    }
    
    // MARK: Child Coordinators

    private func startContentFC() {
        let contentFC = ContentFC(withServices: services)
        contentFC.delegate = self
        contentFC.start()
        addChildFC(contentFC)
        rootViewController.present(contentFC.rootViewController, animated: true)
    }
}

// MARK: - AppFC: StartVCDelegate

extension AppFC: StartVCDelegate {
    func startVCDidTapSearch(startVC: StartVC) {
        startContentFC()
    }
}

// MARK: - AppFC: ContentFCDelegate

extension AppFC: ContentFCDelegate {
    func contentFCDidTapDismiss(contentFC: ContentFC) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
