//
//  NetworkOperation.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/4/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

class NetworkOperation<T: Decodable>: AsyncOperation {
    
    // MARK: Properties
    
    // If nil after completion, there was an error completing the network task
    var response: T? = nil
    
    // The request provided upon initialization
    let request: URLRequest
    
    // The session used for the network data task
    let session = URLSession.shared
    
    
    // MARK: Initializers
    
    // Initialize network operation with a URLRequest and an expected generic type
    init(request: URLRequest) {
        self.request = request
        super.init()
    }
    
    
    // MARK: Methods
    
    override func main() {
        super.main()
        
        guard !isCancelled else {
            print("Network Operation cancelled at start of main: \(request)")
            self.state = .finished
            return
        }
        
        // Call network request provided on initialization
        let task = session.dataTask(with: request) { [weak self] (data, _, error) in
            
            defer {
                // Set state to .finished upon exit, to alert those interested
                self?.state = .finished
            }
            
            // Check for cancellation
            guard !(self?.isCancelled ?? true) else {
                print("Network Operation cancelled after network request: \(String(describing: self?.request))")
                return
            }
            
            // Check that data exists and no errors were provided from network request
            guard let data = data,
                error == nil else {
                    print("Network operation cancelled, network request contained error: \(String(describing: error))")
                    return
            }
            
            // Decode JSON response as given type, otherwise print the error
            do {
                let decoder = JSONDecoder()
                self?.response = try decoder.decode(T.self, from: data)
            } catch {
                print("Error decoding type \(T.self);\n  \(error)")
            }
        }
        
        task.resume()
        
    }
    
}
