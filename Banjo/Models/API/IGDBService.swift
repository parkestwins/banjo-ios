//
//  IGDBService.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - IGDBService

public class IGDBService {
    
    // MARK: Properties
    
    private let queue = OperationQueue()
    private let searchQueue = OperationQueue()

    // MARK: Shared Instance
    
    private init() {}
    
    static let shared = IGDBService()
    
    // MARK: Search
    
    func cancelSearch() {
        searchQueue.cancelAllOperations()
    }
            
    // MARK: Request
    
    func load<T>(_ request: IGDBRequest, type: T.Type, completion: ((ParseOperation<T>) -> (Void))?) {
        guard let urlRequest = request.urlRequest else { return }
        
        let fetch = FetchOperation(request: urlRequest)
        let parse = ParseOperation(type: type)
        parse.addDependency(fetch)
        parse.completionBlock = {
            DispatchQueue.main.async {
                completion?(parse)
            }
        }
        
        switch request {
        case .searchGames:
            searchQueue.addOperation(fetch)
            searchQueue.addOperation(parse)
        default:
            queue.addOperation(fetch)
            queue.addOperation(parse)
        }
    }
}
