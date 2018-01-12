//
//  HTTPMethod.swift
//  ModelExplorer
//
//  Created by Jarrod Parkes on 1/8/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

// MARK: - HTTPMethod: String

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
