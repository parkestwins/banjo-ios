//
//  BaseOperation.swift
//  CommentSoldKit
//
//  Created by Jarrod Parkes on 12/20/17.
//  Copyright © 2017 CommentSold. All rights reserved.
//

import Foundation

// MARK: - BaseOperation: Operation

class BaseOperation: Operation {
    
    // MARK: Properties
    
    var state = OperationState.ready {
        // send KVO triggers for state and anything observing isReady, isExecuting, etc.
        willSet {
            willChangeValue(forKey: newValue.keyPath())
            willChangeValue(forKey: state.keyPath())
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath())
            didChangeValue(forKey: state.keyPath())
        }
    }
    
    // MARK: Operation
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return false
    }
}
