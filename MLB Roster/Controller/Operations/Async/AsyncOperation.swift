//
//  AsyncOperation.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/4/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    
    
    // Usage:
    // - Create subclass of AsyncOperation
    // - Add optional results variable for storage of response.
    //      Optional value in results variable after finishing means the operation was not successful
    // - Override (with super) `start()` and/or `main()` with the usage of the operation
    // - When the request is finished, set `state` equal to .finished
    // Note 1: Constantly check for a cancelled operation
    // Note 2: Set self.completionBlock to response to finished operation
    
    
    // All AsyncOperations must define themselves as such
    override var isAsynchronous: Bool { return true }
    
    // State variable overrides
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
    
    // State variable of operation instance
    var state: AsyncState = .ready {
        
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: state.rawValue)
            didChangeValue(forKey: oldValue.rawValue)
        }
        
    }
    
    
    // Overriding start, called at start of operation
    override func start() {
        
        guard !isCancelled else {
            state = .finished
            return
        }
        state = .ready
        main()
        
    }
    
    // Overriding main, called by start to perform operation's work
    override func main() {
        guard !isCancelled else {
            state = .finished
            return
        }
        state = .executing
        
    }
    
    
    
    
}


