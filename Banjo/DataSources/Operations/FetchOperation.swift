//
//  FetchOperation.swift
//  CommentSoldKit
//
//  Created by Jarrod Parkes on 12/20/17.
//  Copyright © 2017 CommentSold. All rights reserved.
//

import Foundation

// MARK: - FetchOperation: BaseOperation

class FetchOperation: BaseOperation {
    
    // MARK: Properties
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    private let request: URLRequest
    private var task: URLSessionDataTask?
    
    // MARK: Initializer
    
    init(request: URLRequest) {
        self.request = request
        super.init()
        setup()
    }
    
    private func setup() {
        task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.data = data
            self.response = response
            self.error = error
            self.state = .finished
        }
    }
    
    // MARK: Operation
    
    override func start() {
        guard !isCancelled else { return }
        
        state = .executing
        task?.resume()
    }
}
