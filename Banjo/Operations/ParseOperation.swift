//
//  ParseOperation.swift
//  CommentSoldKit
//
//  Created by Jarrod Parkes on 12/20/17.
//  Copyright © 2017 CommentSold. All rights reserved.
//

import Foundation

// MARK: - ParseOperation<T: Decodable>: BaseOperation

class ParseOperation<T: Decodable>: BaseOperation {

    // MARK: Properties
    
    var result: AnyObject?
    var response: URLResponse?
    var error: Error?
    let type: T.Type

    // MARK: Initializer
    
    init(type: T.Type) {
        self.type = type
        super.init()
    }
    
    // MARK: Operation

    override func start() {
        guard !isCancelled else { return }

        state = .executing

        let fetchOperation = dependencies.filter { (operation) -> Bool in
            return operation is FetchOperation
        }.first as? FetchOperation

        // capture response and error or data
        if let fetchOperation = fetchOperation {
            response = fetchOperation.response

            if let error = fetchOperation.error {
                self.error = error
            } else if let data = fetchOperation.data {
                do {
                    try parseData(data)
                } catch {
                    self.error = error
                }
            }
        } else {
            error = NSError(domain: "com.ParkesTwins.ModelExplorer", code: 0, userInfo: nil)
        }

        state = .finished
    }
    
    // MARK: Parse
    
    func parseData(_ data: Data) throws {
        let decoder = JSONDecoder()
        result = try decoder.decode(type, from: data) as AnyObject
    }
}
