//
//  Services.swift
//  Banjo
//
//  Created by Jarrod Parkes on 3/5/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Services

public class Services {
    
    // MARK: Properties
    
    public let igdbService: IGDBService
    
    // MARK: Initializer
    
    public init(igdbService: IGDBService) {
        self.igdbService = igdbService
    }
}
