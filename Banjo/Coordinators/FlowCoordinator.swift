//
//  FlowCoordinator.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - FlowCoordinator

public protocol FlowCoordinator: class {
    var services: Services { get }
    var childFCs: [FlowCoordinator] { get set }        
}

// MARK: - FlowCoordinator (Functions)

public extension FlowCoordinator {
    public func addChildFC(_ childFC: FlowCoordinator) { childFCs.append(childFC) }
    public func removeChildFC(_ childFC: FlowCoordinator) { childFCs = childFCs.filter { $0 !== childFC } }
}
