//
//  RootViewFC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation
import UIKit

// MARK: - RootVCProvider

public protocol RootVCProvider: class {
    // NOTE: 'rootViewController' can be any UIViewController subclass
    // NOTE: this is necessary so it can dismiss coordinator (and its views) from view hierarchy
    var rootViewController: UIViewController { get }
}

public typealias RootViewFC = FlowCoordinator & RootVCProvider
