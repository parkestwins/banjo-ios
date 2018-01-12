//
//  OperationState.swift
//  CommentSoldKit
//
//  Created by Jarrod Parkes on 12/20/17.
//  Copyright © 2017 CommentSold. All rights reserved.
//

// MARK: - OperationState

enum OperationState {
    case ready, executing, finished
    
    // MARK: Key Paths
    
    func keyPath() -> String {
        switch self {
        case .ready:
            return "isReady"
        case .executing:
            return "isExecuting"
        case .finished:
            return "isFinished"
        }
    }
}
